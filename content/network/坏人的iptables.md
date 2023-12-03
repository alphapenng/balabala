# 坏人的 iptables

- [坏人的 iptables](#坏人的-iptables)
  - [名词解释](#名词解释)
  - [iptables 的5个挂钩(5条chains)](#iptables-的5个挂钩5条chains)
  - [iptables 5张表](#iptables-5张表)
  - [链的处理](#链的处理)

## 名词解释

- node
- router
- host
- link
- interface

## iptables 的5个挂钩(5条chains)

iif➡️(PREROUTING)R(FORWARD)➡️➡️➡️➡️➡️(POSTROUTING)oif
---------------------------⬇️-️-️-----------------------⬆️-----
-------------------------(input)-------------------(output)---
----------------------------in---------------------------R-----
---------------------------------------------------------⬆️----
---------------------------------------------------------out---

## iptables 5张表

- filter（过滤）3条链 （I O F）
- nat（网络地址转换） 3条链 （PREROUTING POSTROUTING OUTPUT）
- mangle（修饰）5条链
- raw（原始）
- security（安全）

## 链的处理

- 每条预定义链都会有预定义的处理规则 DROP ACCEPT
- 每条自定义链没有自定义的处理规则 ，默认 RETURN

  ```bash
  iptables -t filter -P FORWARD DROP
  iptables -A FORWARD [match与的关系 -i|-o|-s|-d|-p] [action -j|ACCEPT/DROP/HUAI -g HUAI 不会return，都不匹配就执行默认 FORWARD 规则](append)
  iptables -R FORWARD 1 (remove)
  iptables -I FORWARD 1 (insert before 1)
  iptables -C FORWARD (check)
  iptables -L FORWARD (list)
  iptables -N HUAI (new)
  iptables -A FORWARD -j HUAI
  ```

