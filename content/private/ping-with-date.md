---
2022-12-07 17:56:49
---

# ping-with-date

## Windows

cmd 下执行

```cmd
powershell -c "ping X.X.X.X -t | Foreach{' {0} - {1}' -f  (Get-Date),$_} "
```

当然也可以直接输出保存至文件

```cmd
powershell -c "ping X.X.X.X -t | Foreach{' {0} - {1}' -f  (Get-Date),$_}  >> D:\ping_log.txt"
```

## Linux 和 Macos

```cmd
ping 223.5.5.5 | while read pong; do echo "$(date):$pong"; done
```
