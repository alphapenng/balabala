# nvm_windows

- [nvm\_windows](#nvm_windows)
  - [Overview](#overview)
  - [Installation \& Upgrades](#installation--upgrades)
    - [Install nvm-windows](#install-nvm-windows)
    - [Reinstall any global utilities](#reinstall-any-global-utilities)
  - [Usage](#usage)

## Overview

Remember when running `nvm install` or `nvm use`, Windows usually requires administrative rights (to create symlinks).

![nvm_overview](https://raw.githubusercontent.com/coreybutler/staticassets/master/images/nvm-1.1.8-screenshot.jpg)

![nvm_usage](https://raw.githubusercontent.com/coreybutler/staticassets/master/images/nvm-usage-highlighted.jpg)

## Installation & Upgrades

⚠️ **Uninstall any pre-existing Node installations!!** ⚠️

Uninstall any existing versions of Node.js before installing NVM for Windows (otherwise you'll have conflicting versions). Delete any existing Node.js installation directories (e.g., %ProgramFiles%\nodejs) that might remain. NVM's generated symlink will not overwrite an existing (even empty) installation directory.

👀 **Backup any global npmrc config** 👀 (e.g. %AppData%\npm\etc\npmrc)

Alternatively, copy the settings to the user config `%UserProfile%\.npmrc`. Delete the existing npm install location (e.g. `%AppData%\npm`) to prevent global module conflicts.

### Install nvm-windows

Use the [latest installer](https://github.com/coreybutler/nvm/releases) (comes with an uninstaller). Alternatively, follow the [manual installation](https://github.com/coreybutler/nvm-windows/wiki#manual-installation) guide.

If NVM4W doesn't appear to work immediately after installation, restart the terminal/powershell (not the whole computer).

### Reinstall any global utilities

After install, reinstalling global utilities (e.g. yarn) will have to be done for each installed version of node:

```powershell
nvm use 18.17.0
npm install -g yarn
nvm use 12.19.1
npm install -g yarn
```

## Usage

**nvm-windows runs in an Admin shell.** You'll need to start `powershell` or Command Prompt as Administrator to use nvm-windows

NVM for Windows is a command line tool. Simply type `nvm` in the console for help. The basic commands are:

- `nvm arch [32|64]`: Show if node is running in 32 or 64 bit mode. Specify 32 or 64 to override the default architecture.
- `nvm check`: Check the NVM4W process for known problems.
- `nvm current`: Display active version.
- `nvm install <version> [arch]`: The version can be a specific version, "latest" for the latest current version, or "lts" for the most recent LTS version. Optionally specify whether to install the 32 or 64 bit version (defaults to system arch). Set [arch] to "all" to install 32 AND 64 bit versions. Add `--insecure` to the end of this command to bypass SSL validation of the remote download server.
- `nvm list [available]`: List the node.js installations. Type available at the end to show a list of versions available for download.
- `nvm on`: Enable node.js version management.
- `nvm off`: Disable node.js version management (does not uninstall anything).
- `nvm proxy [url]`: Set a proxy to use for downloads. Leave `[url]` blank to see the current proxy. Set `[url]` to "none" to remove the proxy.
- `nvm uninstall <version>`: Uninstall a specific version.
- `nvm use <version> [arch]`: Switch to use the specified version. Optionally use `latest`, `lts`, or `newest`. `newest` is the latest installed version. Optionally specify 32/64bit architecture. `nvm use <arch>` will continue using the selected version, but switch to 32/64 bit mode. For information about using `use` in a specific directory (or using `.nvmrc`), please refer to [issue #16](https://github.com/coreybutler/nvm-windows/issues/16).
- `nvm root <path>`: Set the directory where nvm should store different versions of node.js. If `<path>` is not set, the current root will be displayed.
- `nvm version`: Displays the current running version of NVM for Windows.
- `nvm node_mirror <node_mirror_url>`: Set the node mirror.People in China can use <https://npmmirror.com/mirrors/node/>
- `nvm npm_mirror <npm_mirror_url>`: Set the npm mirror.People in China can use <https://npmmirror.com/mirrors/npm/>
