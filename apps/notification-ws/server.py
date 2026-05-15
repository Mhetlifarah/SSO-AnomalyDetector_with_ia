#!/usr/bin/env python3
"""
Notification WebSocket Server
- Se connecte a Redis pour recevoir les alertes
- Les diffuse aux navigateurs connectes via WebSocket
"""
import asyncio
import json
import logging
import os
import websockets
import redis.asyncio as aioredis

logging.basicConfig(level=logging.INFO, format='[%(asctime)s] %(message)s')
logger = logging.getLogger("ws-server")

REDIS_HOST = os.getenv("REDIS_HOST", "redis")
REDIS_PORT = int(os.getenv("REDIS_PORT", "6379"))
WS_PORT = int(os.getenv("WS_PORT", "8765"))

connected_clients = set()

async def handle_client(websocket, path=None):
    connected_clients.add(websocket)
    logger.info(f"Client connecte ({len(connected_clients)} total)")

    try:
        await websocket.send(json.dumps({
            "type": "connected",
            "message": "Connecte au serveur d'alertes securite"
        }))

        async for message in websocket:
            pass

    except websockets.exceptions.ConnectionClosed:
        pass
    finally:
        connected_clients.discard(websocket)
        logger.info(f"Client deconnecte ({len(connected_clients)} total)")

async def redis_listener():
    try:
        r = aioredis.Redis(host=REDIS_HOST, port=REDIS_PORT, decode_responses=True)
        pubsub = r.pubsub()
        await pubsub.subscribe("security-alerts")
        logger.info(f"Redis connecte: {REDIS_HOST}:{REDIS_PORT}")

        async for message in pubsub.listen():
            if message["type"] == "message":
                alert_data = message["data"]
                logger.info(f"Alerte recue: {str(alert_data)[:80]}...")

                if connected_clients:
                    disconnected = set()
                    for client in connected_clients:
                        try:
                            await client.send(alert_data)
                        except:
                            disconnected.add(client)

                    connected_clients.difference_update(disconnected)

    except Exception as e:
        logger.error(f"Redis erreur: {e}")

async def main():
    logger.info(f"Serveur WebSocket demarre sur le port {WS_PORT}")

    async with websockets.serve(handle_client, "0.0.0.0", WS_PORT):
        await redis_listener()

if __name__ == "__main__":
    asyncio.run(main())
