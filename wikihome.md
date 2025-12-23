

#wiki
好的，我帮你把今天上午关于 **在 Ubuntu 服务器上部署 PandaWiki 并启用 HTTPS（Caddy 反向代理）** 的所有对话内容整理成一个 **完整、可操作的步骤教程**，按实际情况和最终结果整理，保证可复现。

# PandaWiki 在 Ubuntu 服务器部署完整教程（使用 Caddy + Docker）
## 1️⃣ 前置条件
* Ubuntu 服务器（示例：Ubuntu 24.04 LTS）
* 已安装 Docker 和 Docker Compose
* 已注册域名（示例：wiki.evenight.space）
* 已开通域名解析到服务器公网 IP
* 邮箱（用于 Caddy TLS 自动申请证书，如 269629749@qq.com）

⠀
## 2️⃣ 安装 Docker 和 Docker Compose
（假设你已经有 Docker，如果没有可以用以下命令安装）
# 安装 Docker
sudo apt update
sudo apt install -y docker.io docker-compose

# 启动 Docker 并设置开机自启
sudo systemctl enable --now docker
sudo systemctl status docker

## 3️⃣ 配置 Caddyfile
Caddy 负责自动申请 TLS 并反向代理 PandaWiki 服务。
1. 在 /root 创建 Caddyfile：

⠀nano /root/Caddyfile
1. 写入以下内容：

⠀wiki.evenight.space {
    reverse_proxy 127.0.0.1:2443
    tls 269629749@qq.com
}
注意：
* 127.0.0.1:2443 对应 PandaWiki 后端服务端口
* tls 后面填写你的邮箱，Caddy 会自动申请 HTTPS 证书
* 保存并退出：Ctrl+O → 回车 → Ctrl+X

⠀
## 4️⃣ 创建 Docker Compose 文件
1. 在 /root 创建 docker-compose.yml：

⠀nano /root/docker-compose.yml
1. 写入以下内容（最小可用示例）：

⠀version: "3.8"

services:
  panda-wiki-app:
    image: chaitin-registry.cn-hangzhou.cr.aliyuncs.com/chaitin/panda-wiki-app:latest
    restart: always
    environment:
      - PUBLIC_URL=https://wiki.evenight.space
    depends_on:
      - panda-wiki-api

  panda-wiki-api:
    image: chaitin-registry.cn-hangzhou.cr.aliyuncs.com/chaitin/panda-wiki-api:latest
    restart: always

  panda-wiki-caddy:
    image: chaitin-registry.cn-hangzhou.cr.aliyuncs.com/chaitin/panda-wiki-caddy:2.10-alpine
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /root/Caddyfile:/etc/caddy/Caddyfile
保存退出。

## 5️⃣ 启动 PandaWiki 服务
cd /root
docker compose up -d
* -d 表示后台运行
* 查看容器状态：

⠀docker ps
* 如果有旧容器冲突，先删除旧容器：

⠀docker rm -f panda-wiki-caddy
docker compose up -d

## 6️⃣ 检查服务监听端口
ss -lntp | grep -E '80|443|2443'
输出示例：
0.0.0.0:80       LISTEN  docker-proxy
0.0.0.0:443      LISTEN  docker-proxy
0.0.0.0:2443     LISTEN  docker-proxy
* 80/443 被 Caddy 监听
* 2443 是 PandaWiki 后端服务

⠀
## 7️⃣ 访问 PandaWiki
* 后端服务地址（HTTP）：http://服务器IP:2443/login
* 反向代理地址（HTTPS）：https://wiki.evenight.space/login

⠀注意事项：
* 初次访问 Caddy 会自动申请证书，如果证书未生成，可能显示不安全，稍等几分钟即可。
* 确保防火墙允许 TCP 80 和 443 端口。

⠀
## 8️⃣ 常见问题及解决
1. **HTTP 请求发到 HTTPS 端口** 错误提示：400 Bad Request: The plain HTTP request was sent to HTTPS port
   * 原因：请求 HTTP 到 HTTPS 端口
   * 解决：使用正确协议访问，如 https://wiki.evenight.space
2. **容器名称冲突** 错误提示：The container name "/panda-wiki-caddy" is already in use
   * 解决：删除旧容器再运行：
3. docker rm -f panda-wiki-caddy
4. docker compose up -d
5. 
6. **无法访问网页**
   * 检查 Docker 容器是否启动：docker ps
   * 检查防火墙规则是否放通 80/443/2443 端口
7. **HTTPS 显示“不安全”**
   * 确保 Caddyfile 中 tls 邮箱正确
   * 等待几分钟，让 Caddy 完成证书申请

⠀
✅ 按这个教程走完，你就可以 **通过域名 ~[https://wiki.evenight.space](https://wiki.evenight.space/)~ 安全访问 PandaWiki**，后台服务在 2443 端口运行，Caddy 做反向代理并自动申请 TLS。

如果你需要，我可以帮你画一个 **整体架构图**，标明 PandaWiki、Caddy 和端口映射关系，这样更直观易懂。
你希望我画吗？
