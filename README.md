

# TO-DO
- Add lxappareance lighssmd manager as session manager.
- Correct scripts paths in keybindings/default.conf
- Create a script that retrieves info about the avaiable monitors. See `hyprctl monitors [all]` and currently selected. It will write a variable holding information about the size, the name (edp-1, edp-2) and refresh rate. 
- Make rofi configuration such as the styles for the wallpaper and effects drawer, responsive -> percentage instead of px values.
- Find out if there is some state like "selected on rofi" -> Wallpaper selector.
- Investigate more about how to setup a gui with rofi.
- use the script that gathers information about the monitors to use this information to generate the proper config for waybar (`default/config/`) so height and width are responsive for each monitor
- Create a script that takes as input a list of paths to files or directories and then creates a backup in a path taken as argument too.
- Review the utils' script path resolving.
- Review this install path resolving.
- Create a function that, if DEBUG_ENABLED is set, it executes the process as it is, otherwise, sends to dev null (to mitigate those hard coded usages of forced no debug)
- Create a new system like:
```bash
.
├── .dependencies
│   └── utils
└── inumaki-dotfiles-env
    └── files
```
So that utils get installed in .deps and the remove previous installation action removes inumaki-dotfiles-env, not .deps.
A clean uninstall removes .deps. 
Deps are not removed to allows future installations unless clean uninstall.
- Create a `modules` directory where there will be all the modules such as the setup, 
- change the entry script from `install` to `inumaki`
- `inumaki` allows commands such as install (which runs the setup also)
- `install` command shall allow the current options (-d and -l) `inumaki install [-d | -l]`
- uninstall (removes only dotfiles, not deps nor config files) (this supports -d or --deep)
- backup: backups this dotfiles config (inumaki-dotfiles-env dir)
- install command shall allow --clean or -c to override if previous install is detected (dotfiles, deps will get overriden always)
- Make every single install command to check if the component is alreayd installed. ACtually, refactor every script so that every component to install such as `vcpkg` contains two options: `-i or --install`, `-u or --uninstall` so that when one want to install that component, `vcpkg --install`. Each script of these will contain 3 function,s install, uninstlal and check. 
- every of these scripts can take no options and the default behavior is so install
- Every script will check previously for previous isntalls. 
- If the compnent is installed, skip, unless a force flag is passed
- Add checks for every step.
- Every single steps that can be categorized such as createing afile, shall be normalized, so that an alert can be generated if the process failed.




# inumaki-dotfiles-hyprland
Dotfiles for hyprland

# Usage
```bash
install [-d | -l]
-d: Enables debug output
-l: Enables loggin
```
# Settings

Edit `settings.sh` to alter:
- **HIDDEN_INSTALL:** [default: "false"] Set to "true" to make the the install directory hidde. Otherwise it will be visible.
- **LOG:** [default: "/tmp/logs/install.log] Set it to the path where you want to store the logs.

# Flow
The `install` script runs:
1. A `setup` script
2. A `install` script 

# Setup
Setup mainly installs utilities required for the installation and performs some checks.

# Install
The install scripts 

# Directories that you need to backup because this script will overwrite:
- `$HOME/.zshrc`
- `$HOME/.config/nvim`
- `$HOME/.config/wal`

