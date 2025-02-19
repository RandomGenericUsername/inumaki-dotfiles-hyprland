@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 

{% raw %}
* {
    font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
	/* background-image: none; */
	transition: 20ms;
	box-shadow: none;
	font-size: {{FONT_SIZE}}px;
	background-image: url("{{WLOGOUT_BACKGROUND_IMAGE}}");
}

window {
	background-color: @background;
	background-size: cover;
	color: @foreground;
}


button {
	background-repeat: no-repeat;
    background-position: center;
    background-size: 20%;
    background-color: rgba(200, 220, 255, 0);
    animation: gradient_f 20s ease-in infinite;
    border-radius: 1em; 
	border: 0em;
	transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
}

button:focus {
    background-size: 22%;
	border: 0px;
}

button:hover {
    background-color: @color11;
	opacity: 0.8;
    color: @color12;
    background-size: 30%;
    margin: 3em;
    border-radius: 10em;
    box-shadow: 0 0 0.9em @color7;
}

button span {
    font-size: 1.2em; /* Increase the font size */
}

#lock {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/lock.png"));
}

#logout {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/logout.png"));
}

#suspend {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/suspend.png"));
}

#hibernate {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/hibernate.png"));
}

#shutdown {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/shutdown.png"));
}

#reboot {
    margin: 0.75em;
    border-radius: 0.5em;
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/reboot.png"));
}

{% endraw %}