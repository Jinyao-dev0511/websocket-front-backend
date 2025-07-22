// Simple WebSocket Client
let ws = null;
let isConnected = false;

// DOM elements
const serverUrl = document.getElementById('serverUrl');
const connectBtn = document.getElementById('connectBtn');
const disconnectBtn = document.getElementById('disconnectBtn');
const messageInput = document.getElementById('messageInput');
const sendBtn = document.getElementById('sendBtn');
const clearBtn = document.getElementById('clearBtn');
const messages = document.getElementById('messages');
const status = document.getElementById('status');

// Event listeners
connectBtn.addEventListener('click', connect);
disconnectBtn.addEventListener('click', disconnect);
sendBtn.addEventListener('click', sendMessage);
clearBtn.addEventListener('click', clearMessages);
messageInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') sendMessage();
});

function connect() {
    const url = serverUrl.value.trim();
    if (!url) {
        alert('Please enter WebSocket URL');
        return;
    }

    try {
        ws = new WebSocket(url);
        
        ws.onopen = function(event) {
            isConnected = true;
            updateStatus('Connected', 'connected');
            addMessage('Connected to server', 'system');
            updateButtons();
        };

        ws.onmessage = function(event) {
            addMessage('Server: ' + event.data, 'received');
        };

        ws.onclose = function(event) {
            isConnected = false;
            updateStatus('Disconnected', 'disconnected');
            addMessage('Connection closed', 'system');
            updateButtons();
        };

        ws.onerror = function(error) {
            addMessage('Error: Connection failed', 'error');
        };

    } catch (error) {
        addMessage('Error: ' + error.message, 'error');
    }
}

function disconnect() {
    if (ws && isConnected) {
        ws.close();
    }
}

function sendMessage() {
    const message = messageInput.value.trim();
    if (!message || !isConnected) return;

    ws.send(message);
    addMessage('You: ' + message, 'sent');
    messageInput.value = '';
}

function clearMessages() {
    messages.innerHTML = '';
}

function addMessage(text, type) {
    const div = document.createElement('div');
    div.className = 'message ' + type;
    div.textContent = new Date().toLocaleTimeString() + ' - ' + text;
    messages.appendChild(div);
    messages.scrollTop = messages.scrollHeight;
}

function updateStatus(text, className) {
    status.textContent = text;
    status.className = 'status ' + className;
}

function updateButtons() {
    connectBtn.disabled = isConnected;
    disconnectBtn.disabled = !isConnected;
    messageInput.disabled = !isConnected;
    sendBtn.disabled = !isConnected;
}
