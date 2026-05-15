/**
 * Security Alerts - WebSocket Client
 * Connexion via Nginx proxy : wss://192.168.222.146/ws
 */
(function() {
    var wsProtocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
    var WS_URL = wsProtocol + '//' + window.location.host + '/ws';
    var ws = null;
    var reconnectDelay = 1000;
    var maxReconnectDelay = 30000;

    function connect() {
        try {
            ws = new WebSocket(WS_URL);
        } catch(e) {
            console.error('[Alerts] Erreur creation WebSocket:', e);
            setTimeout(connect, reconnectDelay);
            return;
        }

        ws.onopen = function() {
            console.log('[Alerts] Connecte au serveur WebSocket (' + WS_URL + ')');
            reconnectDelay = 1000;
        };

        ws.onmessage = function(event) {
            try {
                var data = JSON.parse(event.data);
                if (data.type === 'security_alert') {
                    showNotification(data);
                }
            } catch(e) {
                console.error('[Alerts] Erreur parsing:', e);
            }
        };

        ws.onclose = function() {
            console.log('[Alerts] Deconnecte. Reconnexion dans ' + reconnectDelay + 'ms...');
            setTimeout(connect, reconnectDelay);
            reconnectDelay = Math.min(reconnectDelay * 2, maxReconnectDelay);
        };

        ws.onerror = function(err) {
            console.error('[Alerts] Erreur WebSocket');
            ws.close();
        };
    }

    function showNotification(data) {
        var container = document.getElementById('security-alerts');
        if (!container) {
            container = document.createElement('div');
            container.id = 'security-alerts';
            container.style.cssText = 'position:fixed;top:20px;right:20px;z-index:99999;width:380px;pointer-events:none;';
            document.body.appendChild(container);
        }

        var colors = {
            'URGENT':  {bg:'#FF4444', border:'#CC0000', text:'#FFFFFF'},
            'CRITICAL':{bg:'#FF8800', border:'#CC6600', text:'#FFFFFF'},
            'WARNING': {bg:'#FFCC00', border:'#CC9900', text:'#333333'},
            'NORMAL':  {bg:'#44CC44', border:'#009900', text:'#FFFFFF'}
        };
        var c = colors[data.level] || colors['WARNING'];

        var icons = {
            'URGENT': '\uD83D\uDEA8',
            'CRITICAL': '\uD83D\uDD34',
            'WARNING': '\uD83D\uDFE1',
            'NORMAL': '\uD83D\uDFE2'
        };
        var icon = icons[data.level] || '\u26A0';

        var notif = document.createElement('div');
        notif.style.cssText = 'background:' + c.bg + ';color:' + c.text + ';border:2px solid ' + c.border + ';border-radius:8px;padding:16px;margin-bottom:10px;box-shadow:0 4px 12px rgba(0,0,0,0.3);animation:slideIn 0.3s ease-out;font-family:system-ui,-apple-system,sans-serif;pointer-events:auto;';

        notif.innerHTML = '<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">' +
            '<strong style="font-size:14px;">' + icon + ' ' + data.level + '</strong>' +
            '<button onclick="this.parentElement.parentElement.remove()" style="background:none;border:none;color:' + c.text + ';cursor:pointer;font-size:18px;padding:0 4px;">X</button>' +
            '</div>' +
            '<div style="font-size:13px;">' + data.message + '</div>' +
            '<div style="font-size:11px;margin-top:8px;opacity:0.8;">' +
            data.username + ' | ' + data.ip_address + ' | ' + data.action +
            '</div>';

        container.appendChild(notif);

        setTimeout(function() {
            if (notif.parentElement) {
                notif.style.animation = 'slideOut 0.3s ease-in';
                setTimeout(function() { notif.remove(); }, 300);
            }
        }, 15000);
    }

    var style = document.createElement('style');
    style.textContent = '@keyframes slideIn{from{transform:translateX(100%);opacity:0}to{transform:translateX(0);opacity:1}}@keyframes slideOut{from{transform:translateX(0);opacity:1}to{transform:translateX(100%);opacity:0}}';
    document.head.appendChild(style);

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', connect);
    } else {
        connect();
    }
})();
