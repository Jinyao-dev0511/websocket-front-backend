# 🚀 Simple WebSocket Application

A minimal WebSocket application with **vanilla JavaScript** frontend and **InterSystems ObjectScript** backend.

## ✨ Features

- **Simple WebSocket Communication**: Basic echo server
- **Minimal Frontend**: Clean HTML/JS interface
- **ObjectScript Backend**: Simple WebSocket server
- **Docker Ready**: One-command startup

## 🚀 Quick Start

### Prerequisites
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Running

1. **Start the application**
   ```bash
   chmod +x start.sh
   ./start.sh
   ```

2. **Access the application**
   - 🌐 **WebSocket Client**: http://localhost:52773/csp/websocket/
   - 📊 **Management Portal**: http://localhost:52773/csp/sys/UtilHome.csp

### Default Credentials
- **Username**: `SuperUser`
- **Password**: `SYS`

## 🔌 WebSocket

**URL**: `ws://localhost:52773/csp/websocket/WebSocket.Server.cls`

**Function**: Simple echo server - returns whatever message you send

## 📁 Project Structure

```
websocket-front-backend/
├── src/WebSocket/
│   └── Server.cls              # Simple WebSocket echo server
├── web/
│   ├── index.html             # WebSocket client interface
│   └── app.js                 # Client JavaScript
├── docker-compose.yml         # Docker configuration
├── Dockerfile                 # IRIS container
├── iris.script               # IRIS setup script
└── README.md                  # This file
```

## 🔧 How it Works

1. **Backend**: ObjectScript WebSocket server that echoes messages
2. **Frontend**: Simple HTML page with WebSocket client
3. **Docker**: Runs InterSystems IRIS with WebSocket support

## 🛠️ Commands

```bash
# Start
./start.sh

# Stop
docker-compose down

# View logs
docker-compose logs iris

# Access IRIS terminal
docker-compose exec iris iris session iris
```

## 🚨 Troubleshooting

### Common Issues

1. **IRIS startup failure**
   ```bash
   docker-compose down -v
   docker-compose build --no-cache
   docker-compose up -d
   ```

2. **WebSocket connection failure**
   ```bash
   # Check logs
   docker-compose logs iris

   # Verify port is open
   docker-compose ps
   ```

3. **Port conflicts**
   - Modify port `52773` to another port in `docker-compose.yml`

---

**Simple and easy-to-use WebSocket demo project! 🎉**

