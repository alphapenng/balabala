---
2022-08-01 20:46:01
---

# youtube-dl下载视频常用命令

[toc]

* youtube-dl --proxy socks5://127.0.0.1:10808/. -f 22 https://www.youtube.com/watch?v=id --write-auto-sub
* youtube-dl --proxy socks5://127.0.0.1:10808/. -F https://www.youtube.com/watch?v=id
* youtube-dl -f 22 https://www.youtube.com/watch?v=id --write-auto-sub
* youtube-dl -f 22 https://www.youtube.com/watch?v=id --write-sub --sub-lang en
* youtube-dl -F https://www.youtube.com/watch?v=id --list-subs
* you-get -i 'https://www.youtube.com/watch?v=jNQXAC9IVRw'
* you-get --itag=18 'https://www.youtube.com/watch?v=jNQXAC9IVRw'
* To enforce re-downloading, use the --force/-f option. (Warning: doing so will overwrite any existing file or temporary file with the same name!)
* Use the --output-dir/-o option to set the path, and --output-filename/-O to set the name of the downloaded file: $ you-get -o ~/Videos -O zoo.webm 'https://www.youtube.com/watch?v=jNQXAC9IVRw'
* you-get -x 127.0.0.1:8087 'https://www.youtube.com/watch?v=jNQXAC9IVRw'
However, the system proxy setting (i.e. the environment variable http_proxy) is applied by default. To disable any proxy, use the --no-proxy option.
