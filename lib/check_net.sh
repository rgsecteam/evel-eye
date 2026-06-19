#!/bin/bash
# check_net.sh no longer defines colors itself.
# Colors are defined in evel.sh BEFORE load_lib() is called, so they are
# always available when this file is sourced.

# Check internet connection
check_internet() {
    # -c 1: send only 1 packet
    if timeout 3 ping -c 1 www.github.com > /dev/null 2>&1; then
        return 0 # Success
    else
        return 1 # Failure
    fi
}

if check_internet; then
    int_status="${green}online${nocolor}"
    sleep 0.4
else
    int_status="${red}offline${nocolor}"
    sleep 0.2
    echo -e "    ${red}[${orange}!${red}]${white} Connection Offline. Exiting...${nocolor}"
    exit 1
fi
