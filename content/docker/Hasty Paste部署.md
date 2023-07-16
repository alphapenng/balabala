<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-07-16 09:31:13
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-07-16 13:47:59
 * @FilePath: /balabala/content/docker/Hasty Paste部署.md
-->

# Hasty Paste 部署

- [Hasty Paste 部署](#hasty-paste-部署)
  - [什么是 Hasty Paste？](#什么是-hasty-paste)
  - [docker 命令行安装](#docker-命令行安装)
  - [docker-compose 安装](#docker-compose-安装)
  - [参考文档](#参考文档)

## 什么是 Hasty Paste？

`Hasty Paste` 是一个快速粘贴文本并共享的地方，主要用于共享调试日志等，以帮助开发人员提供技术支持。该项目的目标是既快又小。

## docker 命令行安装

```bash
# 新建文件夹 hastypaste 和 子目录
mkdir -p /docker/hastypaste/data

# 进入 hastypaste 目录
cd /docker/hastypaste

# 修改 data 目录权限
chmod 777 ./data

# 运行容器
docker run -d \
   --restart unless-stopped \
   --name hasty-paste \
   -p 8113:8000 \
   -v $(pwd)/data:/app/data \
   ghcr.io/enchant97/hasty-paste:latest
```

## docker-compose 安装

将下面的内容保存为 `docker-compose.yml` 文件

```yaml
version: "3"

services:
  paste-bin:
    image: ghcr.io/enchant97/hasty-paste:latest
    container_name: hasty-paste
    restart: unless-stopped
    ports:
      - 8113:8000
    volumes:
      - ./data:/app/data
```

然后执行下面的命令

```bash
# 新建文件夹 hastypaste 和 子目录
mkdir -p /volume2/docker/hastypaste/data

# 进入 hastypaste 目录
cd /volume2/docker/hastypaste

# 修改 data 目录权限
chmod 777 ./data

# 将 docker-compose.yml 放入当前目录

# 一键启动
docker-compose up -d
```

## 参考文档

> enchant97/hasty-paste: A fast and minimal paste bin.
地址：<https://github.com/enchant97/hasty-paste>
