/* Import the pywal colors */
@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 
{% raw %}

* {
    font-family: {{FONT_FAMILY}};
    font-size: {{FONT_SIZE}}px;
}

window#waybar {
    background-color: {{WAYBAR_BACKGROUND_COLOR}};
    color: {{WAYBAR_COLOR}}; 
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

#clock {
    margin: 0.3em 0em;
    padding: 0 0.25em;
    color: {{CLOCK_COLOR}};
    background-color: {{CLOCK_BACKGROUND_COLOR}};
    font-weight: bold;
    border: none;
    border-radius: 0.25em;
}
#clock:hover {
    background-color: {{CLOCK_HOVER_BACKGROUND_COLOR}}; 
    color: {{CLOCK_HOVER_COLOR}}; 
}

/* -----------------------------------------------------
 * Workspaces 
 * ----------------------------------------------------- 
 */

#workspaces {
    background-color: {{WORKSPACES_BACKGROUND_COLOR}};
    color: {{WORKSPACES_COLOR}};
    margin: 0.3em 0.1em;
    border-radius: 0.20em;
    border: 0rem;
    font-weight: bold;
    font-style: normal;
}

#workspaces button {
    margin: 0.05em 0.15em; 
    /*padding: 0.05em 0.15em; */
    border-radius: 0.20em;
    border: 0em;
    color: {{WORKSPACES_BUTTON_COLOR}};
    background-color: {{WORKSPACES_BUTTON_BACKGROUND_COLOR}};
    transition: all 0.1s linear;
    opacity: 0.4;
    min-width: 1.0em;
}

#workspaces button.active {
    color: {{WORKSPACES_BUTTON_ACTIVE_COLOR}};
    background-color: {{WORKSPACES_BUTTON_ACTIVE_BACKGROUND_COLOR}};
    border-radius: 0.20em;
    min-width: 1.5em;
    transition: all 0.1s linear;
    opacity:1.0;
}

#workspaces button:hover {
    color: {{WORKSPACES_BUTTON_HOVER_COLOR}};
    background: {{WORKSPACES_BUTTON_HOVER_BACKGROUND_COLOR}};
    border-radius: 0.20em;
    opacity:0.7;
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
#battery {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground;
    border-radius: 0.20em;
}
#battery:hover {
    background-color: @color1;
}

#battery.charging, #battery.plugged {
    background-color: @color16;
}

@keyframes blink {
    to {
        background-color: @color8;
        color: @background;
    }
}

#battery.critical:not(.charging) {
    background-color: @color12;
    color: @color14;
    animation-name: blink;
    animation-duration: 5.0s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}


{% endraw %}