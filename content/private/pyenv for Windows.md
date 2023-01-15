<!--
 * @Description: 
 * @Author: alphapenng
 * @Github: 
 * @Date: 2022-07-24 11:30:32
 * @LastEditors: alphapenng
 * @LastEditTime: 2023-01-15 21:45:29
 * @FilePath: /balabala/content/private/pyenv for Windows.md
-->

# pyenv for Windows

[pyenv][1] is a great tool. We have ported it to Windows. We need your thoughts to improve this library and your feedback helps to grow the project.

For existing python users, we support [installation via pip](#installation).

Contributors and Interested people can join us on @[Slack](https://join.slack.com/t/pyenv/shared_invite/zt-f9ydwgyt-Fp8tehxqeCQi5mi77RxpGw). Your help keeps us motivated!

[![pytest](https://github.com/pyenv-win/pyenv-win/actions/workflows/pytest.yml/badge.svg?.inline)](https://github.com/pyenv-win/pyenv-win/actions/workflows/pytest.yml)[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?.inline)](https://opensource.org/licenses/MIT)[![GitHub issues open](https://img.shields.io/github/issues/pyenv-win/pyenv-win.svg?.inline)](https://github.com/pyenv-win/pyenv-win/issues)[![Downloads](https://pepy.tech/badge/pyenv-win?.inline)](https://pepy.tech/project/pyenv-win)[![Rate this package](https://badges.openbase.com/python/rating/pyenv-win.svg?token=hjylt9qszl1DzDMCXNqMQZ6ijtlNCYzG3dKZNF+hgk4=?.inline)](https://openbase.com/python/pyenv-win?utm_source=embedded&amp;utm_medium=badge&amp;utm_campaign=rate-badge)

- [pyenv for Windows](#pyenv-for-windows)
  - [Introduction](#introduction)
  - [pyenv](#pyenv)
  - [pyenv-win commands](#pyenv-win-commands)
  - [Installation](#installation)
      - [**Power Shell**](#power-shell)
      - [**Git Commands**](#git-commands)
      - [**Pyenv-win zip**](#pyenv-win-zip)
      - [**Python pip**](#python-pip)
      - [**Chocolatey**](#chocolatey)
      - [**Add System Settings**](#add-system-settings)
      - [**How to use 32-train**](#how-to-use-32-train)
    - [Validate](#validate)
    - [Manually check the settings](#manually-check-the-settings)
  - [Usage](#usage)
  - [How to update pyenv](#how-to-update-pyenv)
  - [Announcements](#announcements)
  - [FAQ](#faq)

## Introduction

[pyenv][1] for python is a great tool but, like [rbenv][2] for ruby developers, it doesn't directly support Windows. After a bit of research and feedback from python developers, I discovered they wanted a similar feature for Windows systems.

This project was forked from [rbenv-win][3] and modified for [pyenv][1]. It is now fairly mature, thanks to help from many different contributors.

## pyenv

[pyenv][1] is a simple python version management tool. It lets you easily switch between multiple versions of Python. It's simple, unobtrusive, and follows the UNIX tradition of single-purpose tools that do one thing well.

## pyenv-win commands

```yml
   commands     List all available pyenv commands
   local        Set or show the local application-specific Python version
   global       Set or show the global Python version
   shell        Set or show the shell-specific Python version
   install      Install 1 or more versions of Python 
   uninstall    Uninstall 1 or more versions of Python
   update       Update the cached version DB
   rehash       Rehash pyenv shims (run this after switching Python versions)
   vname        Show the current Python version
   version      Show the current Python version and its origin
   version-name Show the current Python version
   versions     List all Python versions available to pyenv
   exec         Runs an executable by first preparing PATH so that the selected Python
   which        Display the full path to an executable
   whence       List all Python versions that contain the given executable
```

## Installation

Currently we support following ways, choose any of your comfort:

- [Power Shell](#power-shell) - easiest way
- [Git Commands](#git-commands) - default way + adding manual settings
- [Pyenv-win zip](#pyenv-win-zip) - manual installation
- [Python pip](#python-pip) - for existing users
- [Chocolatey](#chocolatey)
- [How to use 32-train](#how-to-use-32-train)  
  - [check announcements](#announcements)

Hurray! When you are done here are steps to [Validate](#validate)

_NOTE:_ If you are running Windows 10 1905 or newer, you might need to disable the built-in Python launcher via Start > "Manage App Execution Aliases" and turning off the "App Installer" aliases for Python

***

#### **Power Shell**

The easiest way to install pyenv-win is to run the following installation command in a PowerShell terminal:

```pwsh
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
```

If you are getting any **UnauthorizedAccess** error as below then start Windows PowerShell with the "Run as administrator" option and run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine`, now re-run the above installation command.

```pwsh
& : File C:\Users\kirankotari\install-pyenv-win.ps1 cannot be loaded because running scripts is disabled on this system. For
more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:173
+ ... n.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~ 
 + CategoryInfo          : SecurityError: (:) [], PSSecurityException 
 + FullyQualifiedErrorId : UnauthorizedAccess
```

For more information on 'digitally signed' or 'Security warning' you can refer to following issue [#332](https://github.com/pyenv-win/pyenv-win/issues/332)

Installation is complete!

***

#### **Git Commands**

The default way to install pyenv-win, it needs git commands you need to install git/git-bash for windows

If you are using PowerShell or Git Bash use `$HOME` instead of `%USERPROFILE%`

git clone using command prompt `git clone https://github.com/pyenv-win/pyenv-win.git "%USERPROFILE%\.pyenv"`

steps to [add System Settings](#add-system-settings)

_Note:_ Don't forget the check above link, it contains final steps to complete.

Installation is complete!

***

#### **Pyenv-win zip**

Manual installation steps for pyenv-win

If you are using PowerShell or Git Bash use `$HOME` instead of `%USERPROFILE%`

1. Download [pyenv-win.zip](https://github.com/pyenv-win/pyenv-win/archive/master.zip)

2. Create a `.pyenv` directory using command prompt `mkdir %USERPROFILE%/.pyenv` if not exist

3. Extract and move files to `%USERPROFILE%\.pyenv\`

4. Ensure there is a `bin` folder under `%USERPROFILE%\.pyenv\pyenv-win`

steps to [add System Settings](#add-system-settings)

_Note:_ Don't forget the check above link, it contains final steps to complete.

Installation is complete!

***

#### **Python pip**

For existing python users

If you are using PowerShell or Git Bash use `$HOME` instead of `%USERPROFILE%`

installation command via command prompt  
`pip install pyenv-win --target %USERPROFILE%\\.pyenv`  

if you having an error on above command use the folllowing to resolve it. ref. link [#303](https://github.com/pyenv-win/pyenv-win/issues/303)  
`pip install pyenv-win --target %USERPROFILE%\\.pyenv --no-user --upgrade`

steps to [add System Settings](#add-system-settings)

_Note:_ Don't forget the check above link, it contains final steps to complete.

Installation is complete!

***

#### **Chocolatey**

This needs choco commands to install, [installation link](https://chocolatey.org/install)

Chocolatey command `choco install pyenv-win`

Chocolatey page: [pyenv-win](https://chocolatey.org/packages/pyenv-win)

Installation is complete!

Validate Installation

***

#### **Add System Settings**

It's a easy way to use PowerShell here

1. Adding PYENV, PYENV_HOME and PYENV_ROOT to your Environment Variables

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

   [System.Environment]::SetEnvironmentVariable('PYENV_ROOT',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

   [System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
   ```

2. Now adding the following paths to your USER PATH variable in order to access the pyenv command

   ```pwsh
   [System.Environment]::SetEnvironmentVariable('path', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")
   ```

   Installation is done. Hurray!

***

#### **How to use 32-train**

💁 **Using Git**

1. For 32-train prerequisite is [installing pyenv-win using Git](#git-commands)
2. Go to .pyenv dir command `cd %USERPROFILE%\.pyenv`
3. run `git checkout -b 32bit-train origin/32bit-train`
4. run `pyenv --version` and you should see _2.32.x_

💁 **Using pip**

1. run `pip install pyenv-win==2.32.x --target %USERPROFILE%\.pyenv`

2. steps to [add System Settings](#add-system-settings)

💁 **Using Zip**

1. Download [pyenv-win.zip](https://github.com/pyenv-win/pyenv-win/archive/32bit-train.zip)

2. Follow step 2 from [Pyenv-win zip](#pyenv-win-zip)

3. steps to [add System Settings](#add-system-settings)

***

### Validate

1. Reopen the command prompt and run `pyenv --version`
2. Now type `pyenv` to view it's usage

If you are getting "**command not found**" error, check the below note and [manually check the settings](#manually-check-the-settings)

For Visual Studio Code or another IDE with a built in terminal, restart it and check again  

***

### Manually check the settings

Ensure all environment variables are properly set via the GUI:

```bash
This PC 
   → Properties
      → Advanced system settings 
         → Advanced → Environment Variables... 
            → PATH
```

**NOTE:** If you are running Windows 10 1905 or newer, you might need to disable the built-in Python launcher via Start > "Manage App Execution Aliases" and turning off the "App Installer" aliases for Python

## Usage

- To view a list of python versions supported by pyenv windows: `pyenv install -l`
- To filter the list: `pyenv install -l | findstr 3.8`
- To install a python version:  `pyenv install 3.5.2`
  - _Note: An install wizard may pop up for some non-silent installs. You'll need to click through the wizard during installation. There's no need to change any options in it. or you can use -q for quiet installation_
  - You can also install multiple versions in one command too: `pyenv install 2.4.3 3.6.8`
- To set a python version as the global version: `pyenv global 3.5.2`
  - This is the version of python that will be used by default if a local version (see below) isn't set.
  - _Note: The version must first be installed._
- To set a python version as the local version: `pyenv local 3.5.2`.
  - The version given will be used whenever `python` is called from within this folder. This is different than a virtual env, which needs to be explicitly activated.
  - _Note: The version must first be installed._
- After (un)installing any libraries using pip or modifying the files in a version's folder, you must run `pyenv rehash` to update pyenv with new shims for the python and libraries' executables.
  - _Note: This must be run outside of the `.pyenv` folder._
- To uninstall a python version: `pyenv uninstall 3.5.2`
- To view which python you are using and its path: `pyenv version`
- To view all the python versions installed on this system: `pyenv versions`
- Update the list of discoverable Python versions using: `pyenv update` command for pyenv-win `2.64.x` and `2.32.x` versions

## How to update pyenv

- If installed via pip
  - Add your pyenv-win installation path to `easy_install.pth` file located in site-packages. This should make pip recognise pyenv-win as installed.
  - Get updates via pip `pip install --upgrade pyenv-win`
- If installed via Git
  - Go to `%USERPROFILE%\.pyenv\pyenv-win` (which is your installed path) and run `git pull`
- If installed via zip
  - Download the latest zip and extract it
  - Go to `%USERPROFILE%\.pyenv\pyenv-win` and replace the folders `libexec` and `bin` with the new ones you just downloaded
- If installed via the installer
  - Run the following in a Powershell terminal: `&"${env:PYENV_HOME}\install-pyenv-win.ps1"`

## Announcements

==================  
To keep in sync with [pyenv][1] linux/mac, pyenv-win now installs 64bit versions by default. To support compatibility with older versions of pyenv-win, we maintain a 32bit train (branch) as a separate release.

Both releases can install 64bit and 32bit python versions; the difference is in version names, for example:

- 64bit-train (master), i.e. pyenv version _2.64.x_

```bash
> pyenv install -l | findstr 3.8
....
3.8.0-win32
3.8.0
3.8.1rc1-win32
3.8.1rc1
3.8.1-win32
3.8.1
3.8.2-win32
3.8.2
3.9.0-win32
3.9.0
....
```

- 32bit-train, i.e. pyenv version _2.32.x_

```bash
>pyenv install -l | findstr 3.8
....
3.8.0
3.8.0-amd64
3.8.1rc1
3.8.1rc1-amd64
3.8.1
3.8.1-amd64
3.8.2
3.8.2-amd64
....
```

==================  
Support for Python versions below 2.4 have been dropped since their installers don't install "cleanly" like versions from 2.4 onward and they're predominantly out of use/support in most environments now.

==================  

## FAQ

- **Question:** Does pyenv for windows support python2?
  - **Answer:** Yes, We support python2 from version 2.4+ until python.org officially removes it.
  - Versions below 2.4 use outdated Wise installers and have issues installing multiple patch versions, unlike Windows MSI and the new Python3 installers that support "extraction" installations.

- **Question:** Does pyenv for windows support python3?
  - **Answer:** Yes, we support python3 from version 3.0. We support it from 3.0 until python.org officially removes it.

- **Question:** I am getting the issue `batch file cannot be found.` while installing python, what should I do?
  - **Answer:** You can ignore it. It's just calling `pyenv rehash` command before creating the bat file on some devices.

- **Question:** System is stuck while uninstalling a python version
  - **Answer:** Navigate to the location where you installed pyenv, open its 'versions' folder (usually `%USERPROFILE%\.pyenv\pyenv-win\versions`), and delete the folder of the version you want removed.

- **Question:** I installed pyenv-win using pip. How can I uninstall it?
  - **Answer:** Follow the pip instructions in [How to update pyenv](#how-to-update-pyenv) and then run `pip uninstall pyenv-win`

- **Question:** pyenv-win is not recognised, but I have set the ENV PATH?
  - **Answer:** According to Windows, when adding a path under the User variable you need to logout and login again, in order to reflect any change. For the System variable it's not required.
