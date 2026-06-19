#!/bin/bash

# Package Status
print_status() {
    local label_with_colors="    ${cyan}[${orange}+${cyan}]${nocolor} $1"
    local status=$2
    local total_width=50

    # Remove ANSI color codes to get the "real" visible length
    local clean_label
    clean_label=$(echo -e "$label_with_colors" | sed 's/\x1b\[[0-9;]*m//g')
    local label_len=${#clean_label}

    # Calculate dots based on visible characters
    local dot_count=$((total_width - label_len))

    local dots=""
    if [ "$dot_count" -gt 0 ]; then
        dots=$(printf '%*s' "$dot_count" '' | tr ' ' '.')
    fi

    # Print the original colored label + dots + status
    printf "%b%s %b\n" "$label_with_colors" "$dots" "$status"
}

check_requirements() {
    local requirements=("$@")
    local missing=0

    for package in "${requirements[@]}"; do
        if command -v "$package" >/dev/null 2>&1 || [[ -f "./$package" ]]; then
            print_status "${white}$package" "${green}Installed${nocolor}"
            sleep 0.2
        else
            print_status "${white}$package" "${red}Missing${nocolor}"
            echo -e "    ${red}[${orange}!${red}]${white} $package is required. Installing...${nocolor}"

            # ── Case 1: cloudflared ──────────────────────────────────
            if [[ "$package" == "cloudflared" ]]; then
                local arch url
                arch=$(uname -m)
                case $arch in
                    arm* | armv*)  url="cloudflared-linux-arm"   ;;
                    aarch64*)      url="cloudflared-linux-arm64" ;;
                    x86_64*)       url="cloudflared-linux-amd64" ;;
                    *)             url="cloudflared-linux-386" ;;
                esac

                if wget --no-check-certificate \
                        "https://github.com/cloudflare/cloudflared/releases/latest/download/$url" \
                        -O cloudflared > /dev/null 2>&1; then
                    chmod +x cloudflared
                    echo -e "    ${green}[${white}+${green}]${white} cloudflared installed successfully.${nocolor}"
                else
                    echo -e "    ${red}Error: cloudflared download failed. Exiting.${nocolor}"
                    ((missing++))
                fi

            # ── Case 2: lolcat ───────────────────────────────────────
            elif [[ "$package" == "lolcat" ]]; then
                     
                if [[ "$OS_NAME" == "Android" ]]; then
                    echo -e "    ${cyan}[${white}*${cyan}]${white} Skipping lolcat installation (Android detected).${nocolor}"
                    sleep 0.2
                else
                    # Linux / macOS
                    if [[ "$KERNEL" == "Linux" ]]; then
                        apt update && apt install -y lolcat > /dev/null 2>&1
                    elif [[ "$KERNEL" == "Darwin" ]]; then
                        brew install lolcat > /dev/null 2>&1
                    fi

                    # apt/brew gem
                    if ! command -v lolcat >/dev/null 2>&1; then
                        echo -e "    ${cyan}[${white}*${cyan}]${white} Trying gem install lolcat as fallback...${nocolor}"
                        gem install lolcat > /dev/null 2>&1
                    fi

                    if command -v lolcat >/dev/null 2>&1; then
                        echo -e "    ${green}[${white}*${green}]${white} lolcat installed successfully.${nocolor}"
                    else
                        echo -e "    ${red}[✗] lolcat installation failed.${nocolor}"
                        ((missing++))
                    fi
                fi

            # ── Case 3: Standard Packages (jq, php, wget, etc.) ──────
            else
                if [[ "$OS_NAME" == "Android" ]]; then
                    pkg update -y && pkg install -y "$package" > /dev/null 2>&1
                elif [[ "$KERNEL" == "Linux" ]]; then
                    sudo apt update && sudo apt install -y "$package" > /dev/null 2>&1
                elif [[ "$KERNEL" == "Darwin" ]]; then
                    brew install "$package" > /dev/null 2>&1
                fi

                if command -v "$package" >/dev/null 2>&1; then
                    echo -e "    ${green}[+] $package installed successfully.${nocolor}"
                else
                    echo -e "    ${red}[✗] $package installation failed.${nocolor}"
                    ((missing++))
                fi
            fi

            sleep 0.2
        fi
    done

    # package install fail
    if [[ "$missing" -gt 0 ]]; then
        echo -e "\n    ${red}[✗] $missing package(s) could not be installed. Exiting.${nocolor}"
        exit 1
    fi
}