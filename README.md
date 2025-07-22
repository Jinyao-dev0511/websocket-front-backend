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

**功能**: 简单的echo服务器 - 发送什么消息就返回什么消息

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

### 常见问题

1. **IRIS启动失败**
   ```bash
   docker-compose down -v
   docker-compose build --no-cache
   docker-compose up -d
   ```

2. **WebSocket连接失败**
   ```bash
   # 检查日志
   docker-compose logs iris

   # 确认端口开放
   docker-compose ps
   ```

3. **端口冲突**
   - 修改 `docker-compose.yml` 中的端口 `52773` 为其他端口

---

**简单易用的WebSocket演示项目！ 🎉**
