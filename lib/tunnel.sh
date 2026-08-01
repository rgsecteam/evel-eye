#!/bin/bash

tunnel_menu() {
    { clear; show_banner; banner2; echo; }
cat << EOF
    ${green}<<------ ${white}Select a Tunnel Option ${green}------>>${nocolor}

    ${cyan}[${orange}1${cyan}]${white} Cloudflared
    ${cyan}[${orange}2${cyan}]${white} Localhost
    ${cyan}[${orange}3${cyan}]${white} Back to Main Menu
    ${cyan}[${red}0${cyan}]${red} Exit ${nocolor}

EOF
    read -p "    ${cyan}[${green}+${cyan}]${white} Select an option:${blue} " option_tunnel

    case $option_tunnel in
        1) start_cloudf ;;
        2) start_localhst ;;
        3) back ;;
        0) exit_msg ;;
        *) invalid_options ;;
    esac
}

# ─────────────────────────────────────────────────────────────────────────────
# Detect PHP binary 
# ─────────────────────────────────────────────────────────────────────────────
_get_php_bin() {
    for bin in php php8.5 php8.3 php8.2 php8.1 php8.0 php7.4; do
        if command -v "$bin" >/dev/null 2>&1; then
            echo "$bin"
            return 0
        fi
    done
    return 1
}

# ─────────────────────────────────────────────────────────────────────────────
# Start PHP server on port 9090
# ─────────────────────────────────────────────────────────────────────────────
_start_php_server() {
    local PHP_BIN
    PHP_BIN=$(_get_php_bin)

    if [[ -z "$PHP_BIN" ]]; then
        echo -e "    ${red}[${orange}!${red}]${white} PHP not found! Install with: sudo apt install php${nocolor}"
        exit 1
    fi

    # Kill anything already on 9090
    fuser -k 9090/tcp > /dev/null 2>&1

    echo -e "    ${cyan}[${orange}*${cyan}]${white} Starting PHP server (${green}$PHP_BIN${white})..."
    cd "$SCRIPT_DIR/.server" && $PHP_BIN -S 127.0.0.1:9090 > /dev/null 2>&1 &
    sleep 2

    echo -e "    ${cyan}[${orange}+${cyan}]${white} Local server: ${green}http://127.0.0.1:9090${nocolor}"
}

# ─────────────────────────────────────────────────────────────────────────────
# Cloudflared tunnel
# timeout on link-wait loop
# ─────────────────────────────────────────────────────────────────────────────
start_cloudf() {
    { clear; show_banner; banner2; echo; }
    echo -e "${green}    <<------ ${white}Starting Cloudflared Tunnel ${green}------>>${nocolor}"
    echo -e ""
    _start_php_server
    echo -e "    ${cyan}[${orange}*${cyan}]${white} Starting Cloudflared..."
    cd "$SCRIPT_DIR" || exit 1
    rm -f cf.log

    # Figure out how cloudflared was actually installed — a local binary
    # (downloaded in check_requirements) or one on PATH (brew/pkg/apt).
    # ./cloudflared alone breaks when it was installed system-wide.
    local CF_BIN=""
    if [[ -x "./cloudflared" ]]; then
        CF_BIN="./cloudflared"
    elif command -v cloudflared >/dev/null 2>&1; then
        CF_BIN="cloudflared"
    else
        echo -e "    ${red}[✖] cloudflared binary not found. Exiting.${nocolor}"
        terminate
    fi

    # Kill any stale tunnel from a previous run so we don't end up with
    # two tunnels fighting over the log file / port.
    pkill -f "cloudflared tunnel --url http://127.0.0.1:9090" > /dev/null 2>&1
    sleep 0.3

    # use --url (double dash) and http:// scheme
    "$CF_BIN" tunnel --url http://127.0.0.1:9090 --logfile cf.log > /dev/null 2>&1 &
    local cf_pid=$!

    # Set the trap before we start waiting, so Ctrl+C during link
    # generation also kills the background tunnel instead of leaking it.
    trap 'kill "$cf_pid" 2>/dev/null; terminate' INT

    # wait up to 30 seconds for tunnel link
    echo -ne "    ${cyan}[${orange}*${cyan}]${white} Generating link, please wait..."
    local MAX_WAIT=30
    local count=0
    local cf_link=""
    while true; do
        # If the process died (crash, bad binary, network block) don't
        # keep waiting the full 30s for nothing.
        if ! kill -0 "$cf_pid" 2>/dev/null; then
            echo -e "\n    ${red}[✖] cloudflared process exited unexpectedly.${nocolor}"
            echo -e "    ${red}[!] Check cf.log for details.${nocolor}"
            terminate
        fi

        cf_link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare\.com' "cf.log" 2>/dev/null)
        if [[ -n "$cf_link" ]]; then
            echo -e "\r    ${cyan}[${orange}+${cyan}]${white} Direct Link: ${green}$cf_link${nocolor}           "
            break
        fi

        count=$((count + 1))
        if [[ $count -ge $MAX_WAIT ]]; then
            echo -e "\n    ${red}[✖] Cloudflared link generation timed out after ${MAX_WAIT}s.${nocolor}"
            echo -e "    ${red}[!] Check your cloudflared binary or internet connection.${nocolor}"
            if [[ "$OS_NAME" == "Android" ]]; then
                echo -e "\n    ${red}[${orange}!${red}]${white} If you are using ${orange}Android Termux${white}, please turn on your ${green}mobile hotspot ${white}and try again. ${nocolor}"
            fi
            kill "$cf_pid" 2>/dev/null
            terminate
        fi
        sleep 1
    done

    checked

}

# ─────────────────────────────────────────────────────────────────────────────
# Localhost only
# ─────────────────────────────────────────────────────────────────────────────
start_localhst() {
    { clear; show_banner; banner2; echo; }
    echo -e "${green}    <<------ ${white}Starting Localhost Server ${green}------>>${nocolor}"
    echo -e ""

    _start_php_server

    trap terminate INT
    checked
}
