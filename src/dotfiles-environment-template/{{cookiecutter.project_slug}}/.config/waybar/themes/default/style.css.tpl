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
    min-width: 2.5em;
    padding-top: 0.25em;
    padding-bottom: 0.25em;
    padding-left: 1.5em;
    padding-right: 0em;
    background-repeat: no-repeat;
    background-position: left center;
    background-size: auto 60%;
    color: @foreground; 
    margin: 0.3em 0em;
    border-radius: 0.20em;
    

}
#custom-battery-percentage:hover{
    background-color: @color1;
}

/* Custom battery levels */
#custom-battery-percentage.battery-100 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-100.svg");
    color: @foreground; 
}
#custom-battery-percentage.battery-75 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-75.svg");
    color: @foreground; 
}
#custom-battery-percentage.battery-50 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-50.svg");
    color: @foreground; 
}
#custom-battery-percentage.battery-25 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-25.svg");
    color: @foreground; 
}
#custom-battery-percentage.battery-0 {
    background-image: url("/home/inumaki/Development/inumaki-dotfiles-hyprland/src/assets/waybar/battery-icons/battery-0.svg");
    color: @foreground; 
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