/* Import the pywal colors */
@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 
{% raw %}

* {
    font-family: {{FONT_FAMILY}};
    font-size: {{FONT_SIZE}}px;
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

#clock {
    margin: 0.3em 0em;
    padding: 0 0.25em;
    color: @foreground;
    background-color: transparent;
    font-weight: bold;
    border: none;
    border-radius: 0.25em;
}
#clock:hover {
    background-color: @color1; 
}

/* -----------------------------------------------------
 * Workspaces 
 * ----------------------------------------------------- 
 */

#workspaces {
    background-color: transparent;
    margin: 0.3em 0.1em;
    border-radius: 0.20em;
    border: 0rem;
    font-weight: bold;
    font-style: normal;
}

#workspaces button {
    margin: 0.05em 0.15em; 
    color: @foreground;
    background-color: transparent;
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


tooltip {
    border-radius: 0.2em;
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


#custom-waybar-themes {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground;
    border-radius: 0.20em;
}

#custom-waybar-themes:hover {
    background-color: @color1;
}

#custom-wallpaper-selector {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground;
    border-radius: 0.20em;
}

#custom-wallpaper-selector:hover {
    background-color: @color1;
}

#custom-power-menu {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground;
    border-radius: 0.20em;
}

#custom-power-menu:hover {
    background-color: @color1;
}

#tray {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground;
    border-radius: 0.20em;
}
#tray:hover {
    background-color: @color1;
}
#tray menu{
    color: @foreground;
    font-size: 0.80em;
    background-color: @color1;
}

#custom-battery-percentage {
    margin: 0.3em 0em;
    padding: 0 0.25em;
    color: @foreground;
    background-color: transparent;
    font-weight: bold;
    border: none;
    border-radius: 0.25em;
}

#custom-battery-percentage:hover{
    background-color: @color1;
}

#custom-battery-percentage-icon {
    margin: 0.3em 0em;
    padding: 0 0.25em;
    min-width: 1.5em; 
    min-height: 1.5em;
    background-size: auto 75%; /* 40% 80%; */
    background-repeat: no-repeat;
    background-position: center;
    background-color: transparent;
    color: transparent; /* hide the . text */
    border: none;
    border-radius: 0.25em;
}

#custom-battery-percentage-icon:hover{
    background-color: @color1;
}

#custom-battery-percentage-icon.battery-100 {
    background-image: url("/home/inumaki/Development/temp/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-100.svg");
}

#custom-battery-percentage-icon.battery-75 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-0.svg");
}

#custom-battery-percentage-icon.battery-50 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-0.svg");
}

#custom-battery-percentage-icon.battery-25 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-0.svg");
}

#custom-battery-percentage-icon.battery-0 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-0.svg");
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


{% endraw %}