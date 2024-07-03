kill_waybar() {
    echo "Attempting to kill all Waybar instances"

    # Check if any Waybar instances are running
    if pgrep waybar > /dev/null; then
        echo "Waybar is running, terminating instances..."
        killall waybar
        pkill waybar
        sleep 0.2
        echo "Waybar instances terminated"
    else
        echo "No Waybar instances are running"
    fi
}


waybar_cached_status={{cookiecutter.CACHE_DIR}}/waybar-disabled
theme_style_cfg={{cookiecutter.CACHE_DIR}}/.themestyle.sh

# Check if waybar-disabled file exists
if [ -f $waybar_cached_status ] ;then 
    kill_waybar
    exit 1 
fi

# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
kill_waybar

# ----------------------------------------------------- 
# Default theme: /THEMEFOLDER;/VARIATION
# ----------------------------------------------------- 
themestyle="/default;/default"
#themestyle="/ml4w;/ml4w/light"
echo "Retrieving themestyle from cache: $theme_style"

# ----------------------------------------------------- 
# Get current theme information from .cache/.themestyle.sh
# ----------------------------------------------------- 
if [ -f $theme_style_cfg ]; then
    themestyle=$(cat $theme_style_cfg)
else
    touch $theme_style_cfg
    echo "$themestyle" > $theme_style_cfg
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo "Theme: ${arrThemes[0]}"

if [ ! -f {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/style.css ]; then
    themestyle="/default;/default"
fi

echo "here"
echo $themestyle
# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
config_file="config"
style_file="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/config-custom ] ;then
    config_file="config-custom"
fi
if [ -f {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/style-custom.css ] ;then
    style_file="style-custom.css"
fi

launch="waybar -c {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/$config_file -s {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/$style_file &"


# Check if a custom launch script exists for the theme.
if [ -f {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/main-config ]; then
	echo "Custom waybar command found"
    launch="{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/launch.sh"
fi

# Execute the launch command.
echo "Executing launch command: $launch"
eval $launch

