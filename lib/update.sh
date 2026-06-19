#!/bin/bash

# Configuration
REPO="rgsecteam/evil-eye"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

check_for_updates() {
    echo -e "    ${cyan}[${orange}*${cyan}]${white} Checking for updates (Release)..."
    
    # Fetch latest release tag using curl and grep/sed
    local latest_tag
    latest_tag=$(curl -s "$API_URL" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    if [[ -z "$latest_tag" ]]; then
        echo -e "    ${red}[${orange}!${red}]${white} Could not fetch release info."
        return
    fi

    # Remove 'v' prefix if present for clean comparison (e.g., v0.2 -> 0.2)
    local clean_remote="${latest_tag#v}"
    local clean_local="${version#v}"

    if [[ "$clean_local" != "$clean_remote" ]]; then
        echo -e "    ${cyan}[${green}!${cyan}]${white} New Release available: ${green}$latest_tag${nocolor}"
        read -p "    ${cyan}[${orange}?${cyan}]${white} Update now? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            do_release_update "$latest_tag"
        fi
    else
        echo -e "    ${cyan}[${green}✓${cyan}]${white} You are on the latest release (v$version)."
        sleep 1
    fi
}

do_release_update() {
    local tag=$1
    echo -e "    ${cyan}[${orange}*${cyan}]${white} Downloading release $tag..."
    
    # URL for the source code zip from the release
    local download_url="https://github.com/$REPO/archive/refs/tags/$tag.zip"
    
    cd "$SCRIPT_DIR/.." || exit
    if curl -L "$download_url" -o "update.zip"; then
        unzip -q "update.zip"
        # GitHub zips include a top-level folder like 'evil-eye-0.2'
        local extracted_dir="evil-eye-${tag#v}"
        
        # Replace old files
        rm -rf "evil-eye"
        mv "$extracted_dir" "evil-eye"
        rm "update.zip"
        
        echo -e "    ${green}[${white}✓${green}]${white} Release updated! Restarting..."
        sleep 2
        cd "evil-eye" || exit
        bash evel.sh
        exit
    else
        echo -e "    ${red}[${orange}✖${red}]${white} Download failed."
    fi
}