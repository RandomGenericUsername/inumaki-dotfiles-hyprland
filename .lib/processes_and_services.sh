


detect_running_processes() {
    local running_processes=();
    for process; do
        if pgrep -x "$process" > /dev/null; then
            running_processes+=("$process")
        fi
    done
    echo "${running_processes[@]}"
}

detect_enabled_services() {
    local enabled_services=()
    for service; do
        status=$(systemctl is-enabled "${service}.service" 2>/dev/null)
        if [ "$status" == "enabled" ]; then
            enabled_services+=("$service")
        fi
    done
    echo "${enabled_services[@]}"
}


# Function to disable services
disable_services() {
    for service in "$@"; do
        print "Disabling service: ${service}.service" "debug" "$log"
        systemctl disable "${service}.service"
        systemctl stop "${service}.service"
    done
}

# Function to kill running processes
kill_processes() {
    for process in "$@"; do
        print "Killing process: $process" "debug" "$log"
        pkill -x "$process"
    done
}

