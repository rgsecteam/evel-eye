#!/bin/bash
# banner2() uses color vars defined in evel.sh.
# This file must only be sourced via load_lib() — not run standalone —
# unless colors are pre-defined.

# Version
version="0.3"

small_banner() {
    echo -e "${cyan}    ╔═╗╦  ╦╔═╗╦    ╔═╗╦ ╦╔═╗"
    echo -e "    ║╣ ╚╗╔╝║╣ ║    ║╣ ╚╦╝║╣ "
    echo -e "    ╚═╝ ╚╝ ╚═╝╩═╝  ╚═╝ ╩ ╚═╝${nocolor}"
}

# banner
banner() {
    echo
    echo -e "     ██████████ █████   █████ █████ █████          ██████████ █████ █████ ██████████"
    echo -e "    ▒▒███▒▒▒▒▒█▒▒███   ▒▒███ ▒▒███ ▒▒███          ▒▒███▒▒▒▒▒█▒▒███ ▒▒███ ▒▒███▒▒▒▒▒█"
    echo -e "     ▒███  █ ▒  ▒███    ▒███  ▒███  ▒███           ▒███  █ ▒  ▒▒███ ███   ▒███  █ ▒ "
    echo -e "     ▒██████    ▒███    ▒███  ▒███  ▒███           ▒██████     ▒▒█████    ▒██████   "
    echo -e "     ▒███▒▒█    ▒▒███   ███   ▒███  ▒███           ▒███▒▒█      ▒▒███     ▒███▒▒█   "
    echo -e "     ▒███ ▒   █  ▒▒▒█████▒    ▒███  ▒███      █    ▒███ ▒   █    ▒███     ▒███ ▒   █"
    echo -e "     ██████████    ▒▒███      █████ ███████████    ██████████    █████    ██████████"
    echo -e "    ▒▒▒▒▒▒▒▒▒▒      ▒▒▒      ▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒▒▒▒▒▒ "
}

# banner2
banner2() {
    echo -e "${green}    Camera Phisher by ${redbg}${white}RGSecurityTeam.${nocolor}${white}"
    echo -e "${white}    OS-Detect: ${red}$DISTRO"
    echo -e "${white}    Version: $version ${nocolor}"
}

show_banner() {
    if [[ "$OS_NAME" == "Android" ]]; then
        small_banner
    else
        banner | lolcat
    fi
}