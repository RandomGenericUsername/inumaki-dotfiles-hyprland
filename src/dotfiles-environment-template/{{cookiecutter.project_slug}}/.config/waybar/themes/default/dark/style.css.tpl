/* Import the pywal colors */
@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 
* {
    background-color: transparent;
}

#clock {
    font-family: "Roboto Mono Medium", Helvetica, Arial, sans-serif;
    color: @color1; /* This will be replaced */
    background-color: @color16; /* This will be replaced */
    font-size: 125%;
    border: none;
    padding: 0.20em 0.15em 0.0em 0.15em;
    font-weight: bold;
    border-radius: 0.25rem;
}

#clock:hover {
    color: @color16; /* This will be replaced */
    background-color: @color1; /* This will be replaced */
}

#bluetooth {
}}