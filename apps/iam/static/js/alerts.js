/**
 * Security Alerts - WebSocket Client
 * Affiche les alertes de sécurité en temps réel
 */
(function() {
    const WS_URL = `ws://${window.location.hostname}:8765`;
    let ws = null;
    let reconnectDelay = 1000;
    
    function connect() {
        ws = new WebSocket(WS_URL);
        
        ws.onopen = function() {
            console.log('[Alerts] Connecté au serveur WebSocket');
            reconnectDelay = 1000;
        };
        
        ws.onmessage = function(event) {
            try {
                const data = JSON.parse(event.data);
                if (data.type === 'security_alert') {
                    showNotification(data);
                }
            } catch(e) {
                console.error('[Alerts] Erreur parsing:', e);
            }
        };
        
        ws.onclose = function() {
            console.log(`[Alerts] Déconnecté. Reconnexion dans ${reconnectDelay}ms...`);
            setTimeout(connect, reconnectDelay);
            reconnectDelay = Math.min(reconnectDelay * 2, 30000);
        };
        
        ws.onerror = function(err) {
            console.error('[Alerts] Erreur WebSocket:', err);
            ws.close();
        };
    }
    
    function showNotification(data) {
        // Créer le conteneur s'il n'existe pas
        let container = document.getElementById('security-alerts');
        if (!container) {
            container = document.createElement('div');
            container.id = 'security-alerts';
            container.style.cssText = 'position:fixed;top:20px;right:20px;z-index:99999;width:380px;';
            document.body.appendChild(container);
        }
        
        // Couleurs selon le niveau
        const colors = {
            'URGENT':  {bg:'#FF4444',border:'#CC0000',text:'#FFFFFF'},
            'CRITICAL':{bg:'#FF8800',border:'#CC6600',text:'#FFFFFF'},
            'WARNING': {bg:'#FFCC00',border:'#CC9900',text:'#333333'},
            'NORMAL':  {bg:'#44CC44',border:'#009900',text:'#FFFFFF'}
        };
        const c = colors[data.level] || colors['WARNING'];
        
        // Créer la notification
        const notif = document.createElement('div');
        notif.style.cssText = `
            background:${c.bg}; color:${c.text}; border:2px solid ${c.border};
            border-radius:8px; padding:16px; margin-bottom:10px;
            box-shadow:0 4px 12px rgba(0,0,0,0.3);
            animation: slideIn 0.3s ease-out;
            font-family:system-ui,-apple-system,sans-serif;
        `;
        
        notif.innerHTML = `
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                <strong style="font-size:14px;">🚨 ${data.level}</strong>
                <button onclick="this.parentElement.parentElement.remove()" 
                    style="background:none;border:none;color:${c.text};cursor:pointer;font-size:18px;">✕</button>
            </div>
            <div style="font-size:13px;">${data.message}</div>
            <div style="font-size:11px;margin-top:8px;opacity:0.8;">
                👤 ${data.username} &nbsp; 🌐 ${data.ip_address} &nbsp; 📋 ${data.action}
            </div>
        `;
        
        container.appendChild(notif);
        
        // Suppression automatique après 10 secondes
        setTimeout(() => {
            if (notif.parentElement) {
                notif.style.animation = 'slideOut 0.3s ease-in';
                setTimeout(() => notif.remove(), 300);
            }
        }, 10000);
    }
    
    // Ajouter les animations CSS
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideIn { from {transform:translateX(100%);opacity:0;} to {transform:translateX(0);opacity:1;} }
        @keyframes slideOut { from {transform:translateX(0);opacity:1;} to {transform:translateX(100%);opacity:0;} }
    `;
    document.head.appendChild(style);
    
    // Démarrer la connexion
    connect();
})();
