@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css"); 

* {
    font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
	transition: 20ms;
	box-shadow: none;
	font-size: {% raw %}{{FONT_SIZE}}{% endraw %}px;
    background-image: none;
	background: none;
}

window {
    background-image: none;
	background: url("{% raw %}{{WLOGOUT_BACKGROUND_IMAGE}}{% endraw %}");
	background-size: cover;
    font-size: 1em;
}

button {
    color: @color16;
    border-radius: 1em; 
	border: 0em;
    padding: 0.5em;
    background-repeat: no-repeat;
    background-position: center;
    background-color: transparent;
    background-size: 20%;
    animation: gradient_f 20s ease-in infinite;
	transition: all 0.3s cubic-bezier(.55, 0.0, .28, 1.682), box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
    -gtk-icon-effect: none;
}

button:focus, button:hover {
    background-color: @color10;
	opacity: 0.8;
    background-size: 30%;
    box-shadow: 0 0 0.9em @color7;
}

button span {
    font-size: 1.2em; 
}

#lock {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/lock.png"));
}

#logout {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/logout.png"));
}

#suspend {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/suspend.png"));
}

#hibernate {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/hibernate.png"));
}

#shutdown {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/shutdown.png"));
}

#reboot {
    background-image: image(url("{{cookiecutter.WLOGOUT_DIR}}/icons/reboot.png"));
}
