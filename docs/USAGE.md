# neko-dl Usage Guide

Welcome to **neko-dl**! This guide explains the functionality of each section of the script and what the user should expect from every prompt, in order of execution.

---

## Overview

**neko-dl** is a terminal-based YouTube media downloader powered by `yt-dlp`, presented with a cute, cat-themed interactive TUI experience using `fzf`.

---

## Step-by-Step Functionality & Prompts

### 1. Mascot & Welcome

* Displays the neko-dl mascot and a greeting.

### 2. Cookie Selection

You will be asked how you want to handle cookies:

1. **Default cookies**:

   * Tries `~/.config/yt-dlp/cookies.txt`, or `cookies.enc` if the `.txt` isn't found.
   * If `cookies.enc` is chosen, you'll be prompted for a decryption password.
2. **Custom cookies directory**:

   * You provide the path to your cookie file.
   * If the file is encrypted (`*.enc`), you'll be prompted for a password.
3. **Proceed without cookies**
4. **Exit**

### 3. Save Location

Choose where your media will be saved:

1. **Music**:

   * Default to `~/Music`
   * Prompts for artist and album to create subfolders.
2. **Videos**:

   * Default to `~/Videos`
   * Prompts for a custom subfolder name.
3. **Custom directory**:

   * You provide a custom base path.
   * Then choose between Music or Video, and enter subfolder details.
4. **Exit**

### 4. URL Entry

* Prompted to enter the URL of the video or playlist.

### 5. Title Option

Choose how the output file will be named:

1. **Use default title** (from video metadata)
2. **Set custom title** (you enter it manually)
3. **Exit**

### 6. Format Selection

Based on media type (Music or Video):

**If Music:**
Choose from:

* FLAC
* OPUS
* WAV
* M4A
* MP3
* Exit

**If Video:**
Choose from:

* MKV
* MP4
* WebM
* MOV
* Exit

### 7. Thumbnail Embedding

Choose whether to embed a thumbnail:

1. **Embed thumbnail**
2. **Do not embed**
3. **Exit**

### 8. Download Begins

* A cute loading animation appears.
* The download begins using `yt-dlp`, with live feedback in the terminal.
* Logs are saved to a file named like `yt-dlp-YYYY-MM-DD_HH:MM:SS.log`

### 9. Cleanup

* If a temporary cookies file was created (from decryption), it's securely deleted.

---

## Exit Anytime

At most prompts, you can type `exit` (or variations like `quit`, `qxit`) to gracefully exit the script.

---

Enjoy your downloads and have a purrfect day! 🐾
