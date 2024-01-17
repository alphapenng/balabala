<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-08-20 11:46:11
 * @LastEditors: alphapenng
 * @LastEditTime: 2024-01-17 12:33:15
 * @FilePath: /balabala/content/electron-vue/all-about-electron-vue.md
-->
# All-about-electron-vue

- [All-about-electron-vue](#all-about-electron-vue)
  - [`npm run dev` 报错](#npm-run-dev-报错)
  - [electron 中 Unable to install `vue-devtools`](#electron-中-unable-to-install-vue-devtools)
  - [electron-vue 出现 Starting inspector on 127.0.0.1:5858 failed: permission denied 问题解决](#electron-vue-出现-starting-inspector-on-1270015858-failed-permission-denied-问题解决)

## `npm run dev` 报错

> `npm run dev` 出现 `[Error message "error:0308010C:digital envelope routines::unsupported"](https://stackoverflow.com/questions/69692842/error-message-error0308010cdigital-envelope-routinesunsupported)`

You can try one of these:

**1. Downgrade to Node.js v16.**

- You can reinstall the current LTS version from Node.js’ [website](https://nodejs.org/en/download/releases/).
- You can also use [`nvm`](https://github.com/nvm-sh/nvm). For Windows, use [`nvm-windows`](https://github.com/coreybutler/nvm-windows).

**2. Enable legacy OpenSSL provider.**

On Unix-like (Linux, macOS, Git bash, etc.):

```bash
export NODE_OPTIONS=--openssl-legacy-provider
```

On Windows command prompt:

```cmd
set NODE_OPTIONS=--openssl-legacy-provider
```

On PowerShell:

```powershell
$env:NODE_OPTIONS = "--openssl-legacy-provider"
```

## electron 中 Unable to install `vue-devtools`

> [electron 中 Unable to install `vue-devtools` 的解决方法](https://www.cnblogs.com/william1994/p/13894822.html)

先 npm install vue-devtools --save-dev

然后 把 ready 事件里面注释掉 5 行，再加上一行手动加载的。

*最终 src/main/index.dev.js 里面修改后的内容如下（所有内容）：*

```javascript
/* eslint-disable */

// Install `electron-debug` with `devtron`
require('electron-debug')({ showDevTools: true })
import {  BrowserWindow } from 'electron';
// Install `vue-devtools`
require('electron').app.on('ready', () => {
  let installExtension = require('electron-devtools-installer')
  // installExtension.default(installExtension.VUEJS_DEVTOOLS)
  //   .then(() => {})
  //  .catch(err => {
  //     console.log('Unable to install `vue-devtools`: \n', err)
  //   })
  //参考 https://www.cnblogs.com/wozho/p/10782654.html 和 https://github.com/SimulatedGREG/electron-vue/issues/242
  BrowserWindow.addDevToolsExtension('node_modules/vue-devtools/vender')  //手动加载vue-devtools，前提是 npm install vue-devtools --save-dev
  
})

// Require `main` process to boot app
require('./index')
```

## electron-vue 出现 Starting inspector on 127.0.0.1:5858 failed: permission denied 问题解决

`Starting inspector on 127.0.0.1:5858 failed: permission denied`

这是端口被占用了
找到 `.electron-vue` 文件夹下 ·`dev-runner.js` 文件，修改如下：

```javascript
var args = [
  // '--inspect=5858',
  '--inspect=58585',
  path.join(__dirname, '../dist/electron/main.js')
]
```
