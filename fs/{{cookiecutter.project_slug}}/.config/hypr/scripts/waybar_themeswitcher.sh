# ----------------------------------------------------- 
# Default theme folder
# ----------------------------------------------------- 
themes_path="{{cookiecutter.WAYBAR_THEMES_DIR}}"
# ----------------------------------------------------- 
# Initialize arrays
# ----------------------------------------------------- 
listThemes=""
listNames=""
listNames2=""

# ----------------------------------------------------- 
# Read theme folder
# -----------------------------------------------------
sleep 0.2 
options=$(find $themes_path -maxdepth 2 -type d)
for value in $options
do
    if [ ! $value == "{{cookiecutter.WAYBAR_THEMES_DIR}}/assets" ]; then
        if [ ! $value == "$themes_path" ]; then
            if [ $(find $value -maxdepth 1 -type d | wc -l) = 1 ]; then
                result=$(echo $value | sed "s#{{cookiecutter.WAYBAR_THEMES_DIR}}/#/#g")

                IFS='/' read -ra arrThemes <<< "$result"
                {% raw %}listThemes[${#listThemes[@]}]="/${arrThemes[1]};$result"{% endraw %}
                if [ -f $themes_path$result/config.sh ]; then
                    source $themes_path$result/config.sh
                    listNames+="$theme_name\n"
                    listNames2+="$theme_name~"
                else
                    listNames+="/${arrThemes[1]};$result\n"
                    listNames2+="/${arrThemes[1]};$result~"
                fi
            fi
        fi
    fi
done

# ----------------------------------------------------- 
# Show rofi dialog
# ----------------------------------------------------- 
listNames=${listNames::-2}
choice=$(echo -e "$listNames" | rofi -dmenu -replace -i -no-show-icons -width 30 -p "Themes" -format i)
IFS="~"
input=$listNames2
read -ra array <<< "$input"

# -----------------------------------------------------
# Set new theme by writing the theme information to ~/.cache/.themestyle.sh
# -----------------------------------------------------
if [ "$choice" ]; then
    echo "Loading waybar theme..."
    echo "${listThemes[$choice+1]}" > {{cookiecutter.CACHE_DIR}}/.themestyle.sh
    {{cookiecutter.HYPR_SCRIPTS_DIR}}/apply_waybar_theme.sh
    notify-send "Waybar Theme changed" "to ${array[$choice]}"
fi


