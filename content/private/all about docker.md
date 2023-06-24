<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-06-24 16:01:01
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-06-24 19:48:01
 * @FilePath: /balabala/content/private/all about docker.md
-->

# All about docker

- [All about docker](#all-about-docker)
  - [安装 docker 环境](#安装-docker-环境)
    - [非大陆服务器](#非大陆服务器)
    - [国内服务器](#国内服务器)
    - [修改 Docker 配置](#修改-docker-配置)
  - [docker 项目](#docker-项目)

## 安装 docker 环境

### 非大陆服务器

- 安装 `docker`

    ```bash
    wget -qO- get.docker.com | bash
    ```

    ```bash
    docker -v  #查看 docker 版本
    ```

    ```bash
    systemctl enable docker  # 设置开机自动启动
    ```

- 安装 `docker-compose`

    ```bash
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    ```

    ```bash
    sudo chmod +x /usr/local/bin/docker-compose
    ```

    ```bash
    docker-compose --version  #查看 docker-compose 版本
    ```

### 国内服务器

- 安装 docker

    ```bash
    curl -sSL https://get.daocloud.io/docker | sh
    ```

    ```bash
    docker -v  #查看 docker 版本
    ```

    ```bash
    docker -v  #查看 docker 版本
    ```

- 安装 docker-compose

    ```bash
    curl -L https://get.daocloud.io/docker/compose/releases/download/v2.1.1/docker-compose-uname -s-uname -m > /usr/local/bin/docker-compose

    chmod +x /usr/local/bin/docker-compose

    docker-compose --version  #查看 docker-compose 版本
    ```

### 修改 Docker 配置

以下配置会增加一段自定义内网 IPv6 地址，开启容器的 IPv6 功能，以及限制日志文件大小，防止 Docker 日志塞满硬盘：

```bash
cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "20m",
        "max-file": "3"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF
```

## docker 项目

- OpenCat for Team
- NginxProxyManager
- Serverstatus—— 服务器监控
- UptimeKuma—— 网站监控
- Sshwifty—— 一款专为 Web 设计的 SSH 和 Telnet 连接器
- [docker-flare](https://github.com/soulteary/docker-flare)—— 个人导航页
- [CMA_DNS(Clash+Mosdns+Unbound+AdGuardHome)](https://github.com/hezhijie0327/CMA_DNS)—— 个人dns服务器
- Rustdesk—— 远程桌面
-
