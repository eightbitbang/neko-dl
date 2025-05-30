# neko-dl 🐾

A TUI downloader powered by yt-dlp

## Features

- Supports encrypted and decrypted cookie files.
- Select audio or video formats with best quality presets.
- Supports custom directories with artist/album subfolders for music.
- Supports cookie file usage for restricted or region-locked content.
- Friendly terminal interface using fzf.
- Supports multiple audio codecs (FLAC, OPUS, WAV, M4A & MP3 ) and video containers (MKV, MP4, WEBM, & MOV).
- Embed thumbnails optionally for files.

## Dependencies

- [ffmpeg](https://ffmpeg.org/)
- [fzf](https://github.com/junegunn/fzf)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- Bash, ZSH and Fish are supported.

### Installing Dependencies

#### Arch Linux
```bash/zsh/fish
sudo pacman -Syu ffmpeg fzf yt-dlp
```

#### Debian / Ubuntu
```bash/zsh/fish
sudo apt update
sudo apt install ffmpeg fzf yt-dlp
```

#### Fedora
```bash/zsh/fish
sudo dnf install ffmpeg fzf yt-dlp
```

#### macOS (using Homebrew)
```bash/zsh/fish
brew install ffmpeg fzf yt-dlp
```

#### NixOS
Add the following to `/etc/nixos/configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  ffmpeg
  fzf
  yt-dlp
];
```
Then apply the changes:
```bash/zsh/fish
sudo nixos-rebuild switch
```

## Building the Executable

To compile `neko-dl.sh` into a standalone executable binary (`neko-dl`), use the [shc](https://github.com/neurobin/shc) shell script compiler.

### Install shc

#### Arch Linux
```bash/zsh/fish
sudo pacman -S shc
```

#### Debian / Ubuntu
```bash/zsh/fish
sudo apt update
sudo apt install shc
```

#### Fedora
```bash/zsh/fish
sudo dnf install shc
```

#### macOS (using Homebrew)
```bash/zsh/fish
brew install shc
```

### Compile the Binary

```bash/zsh/fish
chmod +x build.sh
./build.sh
```

This will compile `neko-dl.sh` into an executable binary named `neko-dl`. You can then run it directly or move it into a location on your `$PATH`.

> Optional: Use `strip neko-dl` to reduce binary size.


## Usage

1. Make the script executable:
```bash/zsh/fish
chmod +x neko-dl
```

2. Run the executable:
```bash/zsh/fish
./neko-dl
```
3. Setup executable for system wide usage:

## BASH instuctions

1. Add this to ~/.bashrc
```bash
export PATH="$HOME/.local/bin:$PATH"
```
2. Apply changes:
```bash
source ~/.bashrc
```

## ZSH instructions

1. Add this to ~/.zshrc
```zsh
export PATH="$HOME/.local/bin:$PATH"
```
2. Apply changes:
```zsh
source ~/.zshrc
```

## FISH instructions

1. Add this to config.fish
```fish
set -gx PATH $HOME/.local/bin $PATH
```
2. Apply changes:
```fish
source ~/.config/fish/config.fish
```


4. Follow prompts for cookies, URL, save location, format, and thumbnail preferences.

## Cookie Support

### Firefox:
- Install: [cookies.txt Extension](https://addons.mozilla.org/en-US/firefox/addon/cookies-txt/)
- Export cookies after logging in
- Save as `~/.config/yt-dlp/cookies.txt`

### Chrome:
- Install: [Get cookies.txt Extension](https://chrome.google.com/webstore/detail/get-cookiestxt/kfcokbgbmbljjbfilkdfplklnibmbecp)
- Export cookies and save as above

### Encrypted Cookies Support:
- Run command in the same directory as your cookies.txt file
```bash/zsh/fish
openssl enc -aes-256-cbc -salt -pbkdf2 -in cookies.txt -out cookies.enc
```

## License

MIT License (see LICENSE file)

## Credits

- eightbitbang
- yt-dlp development team
- Thanks to the open source community


## Support

If you enjoy using `neko-dl`, please consider supporting real cats in need.

🐱 **Adopt, don’t shop** – Visit your local shelter and consider adopting a cat.  
🐾 **Donate to a local or global organization that supports feline welfare.**  

Your kindness can change a life. 🖤🐾

