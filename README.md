# ReARMKali ⌛  
*Kali Linux Enhancement Script for ARM64 (for people with Apple M1/M2/M3 Chips running Kali on a VM)*

![Apple Silicon](https://img.shields.io/badge/Silicon-M1/M2/M3_ARM64-red?logo=apple) 
![Kali](https://img.shields.io/badge/Kali_Linux-2024.4-557C94?logo=kalilinux)

## What Does This Do? 🛠️
ReARMKali transforms your vanilla Kali Linux VM into a fully-equipped pentesting environment optimized for Apple Silicon Macs. Inspired by [Chris Alupului's](https://github.com/neosprings) terminal customization work and built on the foundation of [Dewalt-arch's pimpmykali](https://github.com/Dewalt-arch/pimpmykali).

### System Enhancements 🚀
- Pimp My Kali setup and optimization
- Oh My Zsh with carefully selected plugins
- Modern CLI tools:
  - `eza`: Modern replacement for `ls` with icons and git integration
  - `bat`: Enhanced `cat` with syntax highlighting
  - `tmux`: Terminal multiplexer with custom config
  - Shell-GPT for AI-assisted command line work

### Pentesting Tools 🔧
- **RustScan**: Lightning-fast port scanner (ARM64 build)
  - Perfect for CTFs and initial enumeration
  - When stealth isn't a concern and speed is key
- **Kerbrute**: Active Directory testing tool (ARM64-optimized)
  - Username enumeration
  - Password spraying
  - Bruteforcing for Kerberos pre-authentication
- **Ligolo-ng**: Advanced tunneling tool (ARM64 proxy binary)
  - Modern alternative to chisel
  - Handles complex pivoting scenarios

### Terminal Improvements 💅
- **ZSH Plugins**:
  - `git`: Enhanced git integration
  - `eza`: File listing improvements
  - `zsh-autosuggestions`: Fish-like autosuggestions
  - `grc`: Output colorization
  - `sudo`: Double ESC for sudo prefix
  - `colorize`: Syntax highlighting for files
  - `zsh-syntax-highlighting`: Command syntax highlighting
  - `tmux`: Automatic tmux session management

- **Custom Aliases**:
  - `cat` → `batcat`: Enhanced file viewing
  - `ls` → `eza -a`: Modern directory listing with icons
  - `la` → `eza -la`: Detailed listing with hidden files
  - `ll` → `eza -ll`: Detailed listing
  - `nmap` → `grc nmap`: Colorized nmap output

## Requirements ⚙️
- Kali Linux VM running on Apple Silicon Mac (M1/M2/M3)
- Fresh Kali Linux 2024.4 installation recommended
- Internet connection for package downloads

⚠️ **tmux Note**: 
- This setup includes tmux by default for enhanced terminal productivity
- If you're not familiar with tmux, you have two options:
  1. Learn tmux (recommended): Check out [tmux cheatsheet](https://tmuxcheatsheet.com)
  2. Disable tmux: Edit `.zshrc` to:
     - Remove `tmux` from the plugins list
     - Remove or comment out the `ZSH_TMUX_AUTOSTART=true` line

## Quick Install 🚀
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/henrykobutra/reARMKali/refs/heads/main/install.sh)"
```

⚠️ **Note**: 
- The installation process can take a few minutes depending on your system and internet speed
- You'll need to confirm some prompts during installation, so check back occasionally
- Perfect time to grab a coffee, but don't wander too far! ☕

## After Installation 📝
1. Restart your VM to apply all changes
2. Set terminal font to "Hack Nerd Font Mono"
3. Configure SGPT with your OpenAI API key if needed
4. Check `.zshrc` for additional customization options

## DIY Installation 🔧
Want to customize your setup? The `install.sh` script is straightforward and modular. You can:
1. Clone the repository
2. Review the script - it's well-commented and organized by function
3. Comment out or modify sections you don't want
4. Run specific parts manually

Key sections in `install.sh`:
- System updates and base packages
- Oh My Zsh installation and plugin setup
- Modern CLI tools (eza, bat, tmux)
- Pentesting tools compilation
- Terminal customization

## Contributing 🤝
Contributions are very welcome! Some ideas:
- Make the installation process interactive (select which tools to install)
- Add more ARM64-compatible tools
- Improve terminal customization options
- Add your favorite pentesting tools or aliases

Please feel free to:
- Open issues for bugs or feature requests
- Submit pull requests
- Share your customizations
- Suggest improvements

## Credits 🙏
- [Chris Alupului](https://github.com/neosprings) for the terminal customization inspiration
- [Dewalt-arch](https://github.com/Dewalt-arch/pimpmykali) for the excellent Kali optimization scripts
- [Oh My Zsh](https://ohmyz.sh/) community for the amazing shell framework
- All tool creators who make pentesting on ARM64 possible

## Found a Bug? 🐛
Please open an issue or submit a pull request on GitHub!