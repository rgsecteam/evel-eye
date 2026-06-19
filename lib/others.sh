#!/bin/bash

# Kill Background Processes
kill_pid() {
    local check_PID="php cloudflared"
    for process in $check_PID; do
        if pidof "$process" > /dev/null 2>&1; then
            killall "$process" > /dev/null 2>&1
        fi
    done
}

# Capture program terminate (Ctrl+C)
terminate() {
    echo -e "\n\n    ${cyan}[${red}!${cyan}]${red} Program terminated.${nocolor}"
    pkill -f "php" 2>/dev/null
    pkill -f "cloudflared" 2>/dev/null
    move_capture_file 2>/dev/null
    rm -rf "$SCRIPT_DIR/.server/"* 2>/dev/null
    exit 0
}

# Exit Message
exit_msg() {
    echo -e "\n    ${red}[${orange}!${red}]${white} Exiting...${nocolor}"
    pkill -f "php" 2>/dev/null
    pkill -f "cloudflared" 2>/dev/null
    move_capture_file 2>/dev/null
    rm -rf "$SCRIPT_DIR/.server/"* 2>/dev/null
    exit 0
}

# Invalid Options
invalid_options() {
    echo -e "\n    ${red}[${orange}✖${red}]${white} Invalid option! Please try again.${nocolor}"
    sleep 1
    main_menu
}

# Back to Main Menu
back() {
    move_capture_file 2>/dev/null
    rm -rf "$SCRIPT_DIR/.server/"* 2>/dev/null
    main_menu
}

