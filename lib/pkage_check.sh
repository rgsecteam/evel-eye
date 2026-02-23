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

    for pkg in "${requirements[@]}"; do
        # Check if command exists or binary exists in current directory
        if command -v "$pkg" >/dev/null 2>&1 || [[ -f "./$pkg" ]]; then
            print_status "${white}$pkg" "${green}Installed${nocolor}"
            sleep 0.4
        else
            print_status "${white}$pkg" "${red}Missing${nocolor}"
            missing=$((missing + 1))

            echo -e "    ${red}[${orange}!${red}]${white} $pkg is required. Starting automatic installation...${nocolor}"

            # ── Special Case: cloudflared ──────────────────────────────────
            if [[ "$pkg" == "cloudflared" ]]; then
                local arch url
                arch=$(uname -m)
                case $arch in
                    *arm*|*Android*)  url="cloudflared-linux-arm" ;;
                    *aarch64*)        url="cloudflared-linux-arm64" ;;
                    *x86_64*)         url="cloudflared-linux-amd64" ;;
                    *)                url="cloudflared-linux-386" ;;
                esac

                # check wget exit code, not chmod
                if wget --no-check-certificate \
                        "https://github.com/cloudflare/cloudflared/releases/latest/download/$url" \
                        -O cloudflared > /dev/null 2>&1; then
                    chmod +x cloudflared
                    echo -e "    ${green}[${white}+${green}]${white} cloudflared installed successfully.${nocolor}"
                else
                    echo -e "    ${red}Error: cloudflared download failed. Exiting.${nocolor}"
                    exit 1
                fi

            # ── Special Case: lolcat ───────────────────────────────────────
            # lolcat is not always in apt; try gem first
            elif [[ "$pkg" == "lolcat" ]]; then
                local installed=0
                if command -v gem >/dev/null 2>&1; then
                    gem install lolcat > /dev/null 2>&1 && installed=1
                fi
                if [[ $installed -eq 0 ]]; then
                    sudo apt-get install -y lolcat > /dev/null 2>&1 && installed=1
                fi
                if [[ $installed -eq 1 ]]; then
                    echo -e "    ${green}[${white}+${green}]${white} lolcat installed successfully.${nocolor}"
                else
                    echo -e "    ${red}Error: lolcat installation failed. Exiting.${nocolor}"
                    exit 1
                fi

            # ── Standard Packages ──────────────────────────────────────────
            else
                local install_ok=0
                if [ "$KERNEL" == "Linux" ]; then
                    sudo apt-get update && sudo apt-get install -y "$pkg" && install_ok=1
                elif [ "$KERNEL" == "macOS" ]; then
                    brew install "$pkg" && install_ok=1
                elif [ "$KERNEL" == "Cygwin" ]; then
                    apt-cyg install "$pkg" && install_ok=1
                else
                    echo -e "${red}[!] Kernel Not Detected: $KERNEL. Cannot auto-install.${nocolor}"
                    exit 1
                fi

                if [[ $install_ok -eq 1 ]]; then
                    echo -e "    ${green}[${white}+${green}]${white} $pkg installed successfully.${nocolor}"
                else
                    echo -e "    ${red}Error: $pkg installation failed. Exiting.${nocolor}"
                    exit 1
                fi
            fi
            sleep 0.4
        fi
    done

    return $missing
}
