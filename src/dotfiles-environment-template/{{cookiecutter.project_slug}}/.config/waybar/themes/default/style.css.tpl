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

#battery {
    margin: 0.3em 0em;
    padding: 0.1em 0.75em;
    color: @foreground; 
    background: transparent;
    border-radius: 0.20em;
}

#battery:hover {
    background-color: @color1; 
}

#battery.charging:hover, #battery.plugged:hover {
    background-color: @color1;
}

#battery.charging, #battery.plugged {
    background-color: transparent; 
    color: @foreground;
}


@keyframes blink {
    to {
        background-color: @color1; 
        color: @color15; 
    }
}

#battery.critical:not(.charging) {
    background-color: transparent; 
    color: @foreground; 
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}


/* Modify only the tooltip for the clock (calendar) */
#clock tooltip {
    background-color: #222831; /* Dark background */
    border-radius: 8px; /* Rounded corners */
    padding: 10px;
    border: 1px solid #393E46; /* Border color */
}

/* Styling the text inside the calendar tooltip */
#clock tooltip label {
    font-size: 14px;
    font-family: "Fira Code", monospace;
    color: #EEEEEE; /* Light text color */
}

/* Highlight today's date (underlined text in calendar) */
#clock tooltip label u {
    color: #00ADB5; /* Custom color for today */
    font-weight: bold;
}



{% endraw %}