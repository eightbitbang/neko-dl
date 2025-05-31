# neko-dl 🐾

A TUI downloader powered by yt-dlp for unix-like systems.

![neko-dl](https://github.com/user-attachments/assets/a17ae4c1-c8e8-4e0a-a766-f57133379870)



## Features

- Friendly terminal interface using fzf.
- Supports encrypted and decrypted cookie files for restricted/region locked content
- Supports [multiple](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md) sites.
- Select audio or video formats with best quality presets.
- Supports custom output directories with subfolders.
- Supports multiple audio codecs (FLAC, OPUS, WAV, M4A, & MP3) and video containers (MKV, MP4, WEBM, & MOV).
- Optional embed thumbnails

## Feature Roadmap
- Windows support via Powershell and Scoop

## Dependencies

- [ffmpeg](https://ffmpeg.org/)
- [fzf](https://github.com/junegunn/fzf)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- Bash, ZSH and Fish shells are supported.

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
sudo pacman -Syu shc
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
#### NixOS
Add the following to `/etc/nixos/configuration.nix`:
```nix
environment.systemPackages = with pkgs; [
  shc
];
```
Then apply the changes:
```bash/zsh/fish
sudo nixos-rebuild switch
```
### Compile the Binary

```bash/zsh/fish
chmod +x build.sh
./build.sh
```

This will compile `neko-dl.sh` into an executable binary named `neko-dl`. You can then run it directly or move it into a location on your `$PATH`.

> Optional: Use `strip neko-dl` to reduce binary size.


## Usage

1. Make the binary executable:
```bash/zsh/fish
chmod +x neko-dl
```

2. Run the executable:
```bash/zsh/fish
./neko-dl
```
3. Setup executable for system wide usage:

#### BASH instuctions

1. Add this to ~/.bashrc
```bash
export PATH="$HOME/.local/bin:$PATH"
```
2. Apply changes:
```bash
source ~/.bashrc
```

#### ZSH instructions

1. Add this to ~/.zshrc
```zsh
export PATH="$HOME/.local/bin:$PATH"
```
2. Apply changes:
```zsh
source ~/.zshrc
```

#### FISH instructions

1. Add this to config.fish
```fish
set -gx PATH $HOME/.local/bin $PATH
```
2. Apply changes:
```fish
source ~/.config/fish/config.fish
```

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

- yt-dlp development team
- Thanks to the open source community


## Support

If you enjoy using `neko-dl`, please consider supporting real cats in need.

🐱 **Adopt, don’t shop** – Visit your local shelter and consider adopting a cat.  
🐾 **Donate to a local or global organization that supports feline welfare.**  

Your kindness can change a life. 🖤🐾

