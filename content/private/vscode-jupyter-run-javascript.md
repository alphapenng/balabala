<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2023-05-17 20:30:17
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-05-17 20:31:51
 * @FilePath: /balabala/content/private/vscode-jupyter-run-javascript.md
-->

# vscode jupyter extension run javascript

- [vscode jupyter extension run javascript](#vscode-jupyter-extension-run-javascript)
  - [install](#install)

## install

```bash
nvm use 14.17.1 # this was the version I started with, including for verbosity
npm uninstall -g ijavascript
nvm install 16.3.0 # the minor version of v16 I happened to already have, included for verbosity. Other v16 versions may work too.
nvm use 16.3.0
npm install -g ijavascript
ijsinstall --spec-path=full
```
