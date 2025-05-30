#!/bin/bash

# --- neko-dl ---
# Made by eightbitbang with love 🖤
# https://github.com/eightbitbang

neko_mascot() {
cat <<"EOF"
                                      ___
             |\__/,|   (`\        _.-|   |          |\__/,|   (`\
             |o o  |__ _) )      {   |   |          |o o  |__ _) )
           _.( T   )  `  /        "-.|___|        _.( T   )  `  /
 n n._    ((_ `^--' /_<  \         .--'-`-.     _((_ `^--' /_<  \
 <" _ }=- `` `-'(((/  (((/       .+|______|__.-||__)`-'(((/  (((/
EOF
  echo
  echo "          made by eightbitbang with love 🖤"
  echo
}

cute_loading() {
  phrases=(
    "Making biscuits...       "
    "Cleaning paws...         "
    "Stretching whiskers...   "
    "Pouncing on packets...   "
    "Chasing digital mice...  "
    "Clearing hairballs...    "
    "Changing cat litter...   "
  )
  phrase=${phrases[$RANDOM % ${#phrases[@]}]}
  echo -ne "\r$phrase"
  sleep 1.2
  frames=("    " "🐾   " "🐾🐾  " "🐾🐾🐾 " "🐾🐾🐾🐾")
  for frame in "${frames[@]}"; do
    echo -ne "\r$phrase $frame"
    sleep 0.5
  done
  echo -ne "\r\033[K"
}

fzf_menu_or_number() {
  local prompt="$1"
  local options="$2"
  echo "$options" | fzf --prompt "$prompt > " --no-info --height=40% --reverse --border --ansi --header="Press Enter or type number"
}

graceful_exit() {
  echo "Exiting... Have a purrfect day! 🐾"
  exit 0
}

get_custom_input() {
  local prompt="$1"
  read -rp "$prompt (or type 'exit' to quit): " input
  [[ "$input" =~ ^[Qq][Xx]?[Ii]?[Tt]?$ ]] && graceful_exit
  echo "$input"
}

neko_mascot

echo -e "Welcome to neko-dl, powered by yt-dlp! 🐈‍⬛\n"

USER_HOME=$(eval echo "~$USER")
DEFAULT_COOKIES_TXT="$USER_HOME/.config/yt-dlp/cookies.txt"
DEFAULT_COOKIES_ENC="$USER_HOME/.config/yt-dlp/cookies.enc"
CACHE_DIR="$USER_HOME/.cache/neko-dl"
mkdir -p "$CACHE_DIR"

# Cookie selection (reinstated menu)
cookies_opts=$'1) Default cookies (~/.config/yt-dlp/cookies.txt or cookies.enc)\n2) Custom cookies directory\n3) Proceed without cookies\n4) Exit'
cookies_choice=$(fzf_menu_or_number "Choose cookies option" "$cookies_opts")

TEMP_COOKIES=""
case $cookies_choice in
  1*)
    if [[ -f "$DEFAULT_COOKIES_TXT" ]]; then
      COOKIES_FILE="$DEFAULT_COOKIES_TXT"
      echo "Using default cookies.txt: $COOKIES_FILE"
    elif [[ -f "$DEFAULT_COOKIES_ENC" ]]; then
      COOKIES_FILE="$DEFAULT_COOKIES_ENC"
      echo "Using default cookies.enc: $COOKIES_FILE"
      # Decryption logic
      read -s -r -p "Enter password for cookies.enc: " COOKIE_PASS
      echo  # Add newline after password prompt
      TEMP_COOKIES="$CACHE_DIR/cookies_decrypted.txt"
      openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$COOKIES_FILE" -out "$TEMP_COOKIES" -k "$COOKIE_PASS" 2>/dev/null
      if [[ ! -s "$TEMP_COOKIES" ]]; then
        echo "Decryption failed. Check password or cookies.enc file."
        graceful_exit
      fi
      COOKIES_FILE="$TEMP_COOKIES"
    else
      COOKIES_FILE=""
      echo "No cookies.txt or cookies.enc found in default location. Proceeding without cookies."
    fi
    ;;
  2*)
    COOKIES_FILE=$(get_custom_input "Custom cookies directory")
    COOKIES_FILE=$(eval echo "$COOKIES_FILE")
    if [[ "$COOKIES_FILE" == *.enc ]]; then
        echo "Encrypted cookies file detected"
        read -s -r -p "Enter password for cookies.enc: " COOKIE_PASS
        echo  # Add newline after password prompt
        TEMP_COOKIES="$CACHE_DIR/cookies_decrypted.txt"
        openssl enc -aes-256-cbc -d -salt -pbkdf2 -in "$COOKIES_FILE" -out "$TEMP_COOKIES" -k "$COOKIE_PASS" 2>/dev/null
        if [[ ! -s "$TEMP_COOKIES" ]]; then
            echo "Decryption failed. Check password or cookies.enc file."
            graceful_exit
        fi
        COOKIES_FILE="$TEMP_COOKIES"
    fi
    [[ ! -f "$COOKIES_FILE" ]] && echo "Custom cookie file not found." && graceful_exit
    ;;
  3*) COOKIES_FILE="" ;;
  *) graceful_exit ;;
esac

# Save location (no changes needed)
save_opts=$'1) Music (~/Music)\n2) Videos (~/Videos)\n3) Custom directory\n4) Exit'
save_choice=$(fzf_menu_or_number "Choose save location" "$save_opts")

case $save_choice in
  1*)
    BASE_DIR="$USER_HOME/Music"
    ARTIST=$(get_custom_input "Enter artist name (subfolder)")
    ALBUM=$(get_custom_input "Enter album name (subfolder)")
    SAVE_DIR="$BASE_DIR/$ARTIST/$ALBUM"
    MEDIA_TYPE="audio"
    ;;
  2*)
    BASE_DIR="$USER_HOME/Videos"
    FOLDER_NAME=$(get_custom_input "Enter name for subfolder")
    SAVE_DIR="$BASE_DIR/$FOLDER_NAME"
    MEDIA_TYPE="video"
    ;;
  3*)
    BASE_DIR=$(get_custom_input "Enter custom save directory")
    media_type_opts=$'1) Music\n2) Video\n3) Exit'
    media_type_choice=$(fzf_menu_or_number "Specify type for custom directory" "$media_type_opts")
    case $media_type_choice in
      1*)
        ARTIST=$(get_custom_input "Enter artist name (subfolder)")
        ALBUM=$(get_custom_input "Enter album name (subfolder)")
        SAVE_DIR="$BASE_DIR/$ARTIST/$ALBUM"
        MEDIA_TYPE="audio"
        ;;
      2*)
        FOLDER_NAME=$(get_custom_input "Enter name for subfolder")
        SAVE_DIR="$BASE_DIR/$FOLDER_NAME"
        MEDIA_TYPE="video"
        ;;
      *) graceful_exit ;;
    esac
    ;;
  4*) graceful_exit ;;
esac

mkdir -p "$SAVE_DIR"
cd "$SAVE_DIR" || graceful_exit

URL=$(get_custom_input "Enter URL")

title_opts=$'1) Use default title\n2) Set custom title\n3) Exit'
title_choice=$(fzf_menu_or_number "Choose title option" "$title_opts")

case $title_choice in
  2*) CUSTOM_TITLE=$(get_custom_input "Enter custom title") ;;
  3*) graceful_exit ;;
  *) CUSTOM_TITLE="" ;;
esac

# Format selection (no changes needed)
if [[ "$MEDIA_TYPE" == "audio" ]]; then
  audio_format_opts=$'1) FLAC (Lossless, best quality)\n2) OPUS (High quality, smaller size)\n3) WAV (Uncompressed)\n4) M4A (Apple compatible)\n5) MP3 (Wide compatibility)\n6) Exit'
  audio_choice=$(fzf_menu_or_number "Choose audio format" "$audio_format_opts")
  case $audio_choice in
    1*) FORMAT_OPTS="--extract-audio --audio-format flac --audio-quality 0"; EXT=".flac" ;;
    2*) FORMAT_OPTS="--extract-audio --audio-format opus --audio-quality 0"; EXT=".opus" ;;
    3*) FORMAT_OPTS="--extract-audio --audio-format wav --audio-quality 0"; EXT=".wav" ;;
    4*) FORMAT_OPTS="--extract-audio --audio-format m4a --audio-quality 0";
    EXT=".m4a" ;;
    5*) FORMAT_OPTS="--extract-audio --audio-format mp3 --audio-quality 0"; EXT=".mp3" ;;
    6*) graceful_exit ;;
    *) graceful_exit ;;
  esac
elif [[ "$MEDIA_TYPE" == "video" ]]; then
  video_format_opts=$'1) MKV (Best quality, versatile)\n2) MP4 (Wide compatibility)\n3) WebM (Modern, standard quality)\n4) MOV (QuickTime, Apple compatible)\n5) Exit'
  video_choice=$(fzf_menu_or_number "Choose video format" "$video_format_opts")
  case $video_choice in
    1*) FORMAT_OPTS="-f bestvideo+bestaudio --merge-output-format mkv"; EXT=".mkv" ;;
    2*) FORMAT_OPTS="-f bestvideo+bestaudio --merge-output-format mp4"; EXT=".mp4" ;;
    3*) FORMAT_OPTS="-f bestvideo+bestaudio --merge-output-format webm"; EXT=".webm" ;;
    4*) FORMAT_OPTS="-f bestvideo+bestaudio --merge-output-format mov"; EXT=".mov" ;;
    5*) graceful_exit ;;
    *) graceful_exit ;;
  esac
fi

# Thumbnail (no changes needed)
thumb_opts=$'1) Embed thumbnail\n2) Do not embed\n3) Exit'
thumb_choice=$(fzf_menu_or_number "Thumbnail option" "$thumb_opts")
case $thumb_choice in
  1*) THUMB_OPT="--embed-thumbnail" ;;
  2*) THUMB_OPT="" ;;
  3*) graceful_exit ;;
esac

OUTPUT_TEMPLATE="%(title)s.%(ext)s"
[[ -n "$CUSTOM_TITLE" ]] && OUTPUT_TEMPLATE="$CUSTOM_TITLE.%(ext)s"

YT_CMD=(yt-dlp $FORMAT_OPTS $THUMB_OPT -o "$OUTPUT_TEMPLATE" "$URL")
[[ -n "$COOKIES_FILE" ]] && YT_CMD+=(--cookies "$COOKIES_FILE")

LOGFILE="yt-dlp-$(date +%F_%T).log"

cute_loading
"${YT_CMD[@]}" 2>&1 | tee "$LOGFILE" | while IFS= read -r line; do
  if [[ "$line" =~ \[youtube\]|\[download\]|\[ExtractAudio\]|\[info\] ]]; then
    cute_loading
  fi
done

# Cleanup
if [[ -n "$TEMP_COOKIES" && -f "$TEMP_COOKIES" ]]; then
  rm -f "$TEMP_COOKIES"
  echo "Deleted temporary cookies file."
fi

echo -e "\n🎵 Download complete! neko-dl signing out 🐱💤"
