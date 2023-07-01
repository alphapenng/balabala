<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-04-23 20:44:14
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-04-23 21:43:17
 * @FilePath: /balabala/content/private/构建支持中文的 Ubuntu 20.04 Docker 镜像.md
-->

# 构建支持中文的 Ubuntu 20.04 Docker 镜像

- [构建支持中文的 Ubuntu 20.04 Docker 镜像](#构建支持中文的-ubuntu-2004-docker-镜像)

由于需要在服务器上生成 excel 及 word，需要镜像支持中文。以下是构建支持中文的 Dockerfile

```bash
FROM ubuntu:20.04

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends  \
        tzdata curl ca-certificates  \
        libfontconfig \
        libfreetype6 \
        xfonts-cyrillic \
        xfonts-scalable \
        fonts-liberation \
        fonts-ipafont-gothic \
        fonts-wqy-zenhei \
        fonts-tlwg-loma-otf \
        ttf-ubuntu-font-family \
        fontconfig locales \
        && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
        && locale-gen en_US.UTF-8 \
        && rm -rf /var/lib/apt/lists/* \
        && apt-get -qyy clean
```

如果是其他的 ubuntu 版本，更换 FROM 就可以了。
