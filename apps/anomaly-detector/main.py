#!/usr/bin/env python3
import json
import sys
import os
from datetime import datetime
import numpy as np
from confluent_kafka import Consumer

sys.path.append('/app')
from config import *
from models.isolation_forest import AnomalyDetectorModel

def is_normal_event(event):
    """
    Vérifie si un événement est NORMAL pour l'entraînement.
    Les événements du bridge Keycloak ont souvent session_id='none' et user_agent='unknown',
    donc on ne les filtre PAS sur ces critères (ils sont quand même valides).
    """
    # 1. Vérifier l'heure (critère important)
    event_time_sec = parse_event_time(event.get('event_time'))
    dt = datetime.fromtimestamp(event_time_sec)
    if not is_normal_hour(dt):
        return False
    
    # 2. Vérifier l'IP
    ip = event.get('ip_address', '')
    if not is_trusted_ip(ip):
        return False
    
    # 3. Vérifier l'action (LOGIN_ERROR est OK pour l'entraînement)
    event_type = event.get('type', '')
    if not is_normal_action(event_type):
        return False
    
    # NOTE: On NE vérifie PAS session_id ni user_agent car le bridge
    # Keycloak ne fournit pas ces infos (session_id='none', user_agent='unknown')
    
    return True

def collect_training_events(limit=500):
    print(f"📥 Connexion à Kafka: {KAFKA_BOOTSTRAP}")
    print(f"📦 Topic: {KAFKA_TOPIC}")
    print(f"🎯 Limite: {limit} messages (timeout: 15s sans nouveau message)")
    print("-" * 50)
    
    conf = {
        'bootstrap.servers': KAFKA_BOOTSTRAP,
        'group.id': 'train-model-group-' + str(int(datetime.now().timestamp())),
        'auto.offset.reset': 'earliest',
        'enable.auto.commit': True
    }
    
    consumer = Consumer(conf)
    consumer.subscribe([KAFKA_TOPIC])
    
    events = []
    count = 0
    empty_polls = 0
    MAX_EMPTY_POLLS = 15
    
    while len(events) < limit:
        msg = consumer.poll(1.0)
        if msg is None:
            empty_polls += 1
            if empty_polls >= MAX_EMPTY_POLLS and count > 0:
                print(f"\n⏱️ Plus de messages après {MAX_EMPTY_POLLS}s ({count} messages collectés)")
                break
            continue
        if msg.error():
            continue
        
        empty_polls = 0
        try:
            event = json.loads(msg.value().decode('utf-8'))
            events.append(event)
            count += 1
            if count % 20 == 0:
                print(f"   ✅ {count} messages collectés")
        except Exception as e:
            continue
    
    consumer.close()
    print(f"\n✅ Total collecté: {len(events)} événements")
    return events

def main():
    print("=" * 70)
    print("🎓 ENTRAÎNEMENT MODÈLE ISOLATION FOREST")
    print("=" * 70)
    print(f"\n📋 CRITÈRES D'ÉVÉNEMENT NORMAL:")
    print(f"   ✅ Heures: {NORMAL_HOURS_START}h à {NORMAL_HOURS_END}h")
    print(f"   ✅ IPs: {TRUSTED_IP_PREFIXES}")
    print(f"   ✅ Actions: {NORMAL_ACTIONS[:6]}...")
    print(f"   ✅ Min événements: {TRAINING_MIN_EVENTS}")
    print(f"   ℹ️  session_id/user_agent ignorés (bridge Keycloak)")
    print("=" * 70)
    
    all_events = collect_training_events(TRAINING_MIN_EVENTS)
    
    if len(all_events) == 0:
        print("❌ Aucun événement trouvé dans Kafka!")
        sys.exit(1)
    
    normal_events = [e for e in all_events if is_normal_event(e)]
    
    print(f"\n📊 FILTRAGE:")
    print(f"   📥 Total reçus: {len(all_events)}")
    print(f"   ✅ Événements normaux: {len(normal_events)}")
    print(f"   ❌ Événements rejetés: {len(all_events) - len(normal_events)}")
    
    # Afficher pourquoi les événements sont rejetés
    rejected = [e for e in all_events if not is_normal_event(e)]
    if rejected:
        print(f"\n📋 Raisons du rejet (échantillon):")
        for e in rejected[:5]:
            event_time_sec = parse_event_time(e.get('event_time'))
            dt = datetime.fromtimestamp(event_time_sec)
            reasons = []
            if not is_normal_hour(dt):
                reasons.append(f"heure={dt.hour}h")
            if not is_trusted_ip(e.get('ip_address', '')):
                reasons.append(f"ip={e.get('ip_address','')}")
            if not is_normal_action(e.get('type', '')):
                reasons.append(f"type={e.get('type','')}")
            print(f"   ❌ {e.get('type','?'):15} | {e.get('username','?'):10} | raisons: {', '.join(reasons)}")
    
    if len(normal_events) < 10:
        print(f"\n❌ Pas assez d'événements normaux ({len(normal_events)} < 10)")
        sys.exit(1)
    
    print(f"\n🧠 Entraînement sur {len(normal_events)} événements normaux...")
    model = AnomalyDetectorModel()
    model.train(normal_events)
    model.save()
    
    print("\n🔍 TEST RAPIDE:")
    test_event = normal_events[0]
    is_anomaly, score = model.predict(test_event)
    print(f"   📝 Événement test: {test_event.get('type')}")
    print(f"   🎯 Prédiction: {'ANOMALIE' if is_anomaly else 'NORMAL'}")
    print(f"   📊 Score ML: {score:.3f}")
    
    print("\n" + "=" * 70)
    print("✅ ENTRAÎNEMENT TERMINÉ AVEC SUCCÈS!")
    print("=" * 70)

if __name__ == "__main__":
    main()
