/* Import the pywal colors */
@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 

/*======= DEFAULTS =======*/
{% raw %}
* {
    font-family: {{FONT_FAMILY}};
    font-size: {{FONT_SIZE}}px;
    border: none;
    border-radius: 0.25em;
    color: @foreground;
    background-color: transparent;
    font-weight: bold;
    margin: 0.1em 0.0em;
}
{% endraw %}

/*======= WORKSPACES =======*/
#workspaces {
}
#workspaces button {
    margin: 0.05em 0.15em; 
    color: @foreground;
    transition: all 0.1s linear;
    min-width: 1.0em;
}
#workspaces button:hover {
    background-color: @color2;
}
#workspaces button.active {
    background-color: @color1;
    min-width: 1.5em;
}
#workspaces button.active:hover {
    background-color: @color1;
}

/*======= CUSTOM/WAYBAR-THEMES =======*/
#custom-waybar-themes {
    padding: 0.1em 0.5em;
}
#custom-waybar-themes:hover {
    background-color: @color1;
}

/*======= CUSTOM/WALLPAPER-SELECTOR =======*/
#custom-wallpaper-selector {
    padding: 0.1em 0.5em;
}
#custom-wallpaper-selector:hover {
    background-color: @color1;
}

/*======= TRAY =======*/
#tray {
    padding: 0.1em 0.5em;
}
#tray:hover {
    background-color: @color1;
}
#tray menu{
    font-size: 0.80em;
    background-color: @color1;
}

/*======= CUSTOM/BATTERY-PERCENTAGE-ICON =======*/
#custom-battery-percentage-icon {
    padding: 0.1em 0.5em;
    min-width: 0.75em;
    background-size: auto 65%;
    background-repeat: no-repeat;
    background-position: center;
    color: transparent; /* hide the . text */
}
#custom-battery-percentage-icon:hover{
    background-color: @color1;
}
#custom-battery-percentage-icon.battery-100 {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-100.svg");
}
#custom-battery-percentage-icon.battery-75 {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-75.svg");
}
#custom-battery-percentage-icon.battery-50 {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-50.svg");
}
#custom-battery-percentage-icon.battery-25 {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-25.svg");
}
#custom-battery-percentage-icon.battery-0 {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-0.svg");
}
#custom-battery-percentage-icon.battery-100-charging {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-100-charging.svg");
}
#custom-battery-percentage-icon.battery-75-charging {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-75-charging.svg");
}
#custom-battery-percentage-icon.battery-50-charging {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-50-charging.svg");
}
#custom-battery-percentage-icon.battery-25-charging {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-25-charging.svg");
}
#custom-battery-percentage-icon.battery-0-charging {
    background-image: url("{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-0-charging.svg");
}

/*======= CUSTOM/BATTERY-PERCENTAGE =======*/
#custom-battery-percentage {
    padding: 0.1em 0.5em;
}
#custom-battery-percentage:hover{
    background-color: @color1;
}

/*======= CLOCK =======*/
#clock {
    padding: 0.1 0.5em;
}
#clock:hover {
    background-color: @color1; 
}

/*======= CUSTOM/POWER-MENU =======*/
#custom-power-menu {
    padding: 0.1em 0.5em;
}
#custom-power-menu:hover {
    background-color: @color1;
}


/*======= TOOLTIP =======*/
tooltip {
    background-color: @background;
    opacity: 1.0;
    padding: 0.5em;
    margin: 0em;
}
tooltip label {
    color: @color1;
    font-size: 0.95em;
    font-weight: bold;
}







window#waybar {
    background-color: transparent;
    color: @color7; 
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}




















#bluetooth {
    margin: 0.3em 0em;
    padding: 0 0.25em;
    color: @foreground;
    background-color: transparent;
    /* font-weight: bold; */
    border: none;
    border-radius: 0.25em;
}
#bluetooth:hover {
    background-color: @color1; 
}



