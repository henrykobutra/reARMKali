#!/bin/sh

# Define color formatting
FMT_GREEN='\033[0;32m'
FMT_BLUE='\033[0;34m'
FMT_YELLOW='\033[0;33m'
FMT_BOLD='\033[1m'
FMT_RESET='\033[0m'

# Pulse spinner with elapsed time
spinner() {
  local pid=$1
  local delay=0.2
  local start=$(date +%s)
  while ps -p $pid > /dev/null; do
    local current=$(date +%s)
    local elapsed=$((current - start))
    printf "\r${FMT_BLUE}[  ●  ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[ ●   ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[●    ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[ ●   ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[  ●  ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[   ● ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[    ●]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
    printf "\r${FMT_BLUE}[   ● ]${FMT_RESET} %02d:%02d " $((elapsed/60)) $((elapsed%60))
    sleep $delay
  done
  printf "\r              \r"
}

# Print initial warning and get confirmation
print_warning() {
    printf '\n'
    printf '\033[38;5;208m                      \n'
    printf '\033[38;5;147m _ _ /\  _ _ |_/ _ |. \n'
    printf '\033[38;5;111m| (-/--\| |||| \(_||| \n'
    printf '\033[38;5;75m                      \n'
    printf "${FMT_RESET}"
    echo "${FMT_YELLOW}https://github.com/henrykobutra/reARMKali${FMT_RESET}"
    printf '\n'
    echo "${FMT_BOLD}⚠️  IMPORTANT: System Requirements${FMT_RESET}"
    echo "${FMT_YELLOW}This script is specifically designed for:${FMT_RESET}"
    echo "${FMT_BLUE}•${FMT_RESET} Kali Linux running on a Virtual Machine"
    echo "${FMT_BLUE}•${FMT_RESET} MacBooks with ARM architecture (M1/M2/M3)"
    printf '\n'
    echo "${FMT_YELLOW}Tested successfully with:${FMT_RESET}"
    echo "${FMT_BLUE}•${FMT_RESET} Kali Linux 2024.4"
    echo "${FMT_BLUE}•${FMT_RESET} MacBook Pro with M1 Pro"
    printf '\n'
    echo "${FMT_BOLD}This script will:${FMT_RESET}"
    echo "${FMT_BLUE}•${FMT_RESET} Update system packages"
    echo "${FMT_BLUE}•${FMT_RESET} Install and configure Pimp My Kali"
    echo "${FMT_BLUE}•${FMT_RESET} Set up Oh My Zsh with custom plugins"
    echo "${FMT_BLUE}•${FMT_RESET} Install essential tools (eza, tmux, bat, etc.)"
    echo "${FMT_BLUE}•${FMT_RESET} Install pentesting tools (RustScan, Kerbrute, Ligolo-ng)"
    echo "${FMT_BLUE}•${FMT_RESET} Configure terminal appearance with Hack Nerd Font"
    printf '\n'
    echo "${FMT_YELLOW}Would you like to continue? [y/N]${FMT_RESET}"
    read -r response
    case "$response" in
        [yY]) 
            return 0
            ;;
        *)
            echo "${FMT_BLUE}•${FMT_RESET} Installation cancelled."
            exit 1
            ;;
    esac
}

# Call the warning message and get confirmation
print_warning

# Start of install
echo "${FMT_BLUE}•${FMT_RESET} Starting reARMKali setup script..."

# Update system
echo "${FMT_BLUE}•${FMT_RESET} Updating system packages... (1/12)"
sudo apt update -q > /dev/null 2>&1

# Pimp My Kali https://github.com/Dewalt-arch/pimpmykali
echo "${FMT_BLUE}•${FMT_RESET} Setting up Pimp My Kali... (2/12)"
echo "${FMT_YELLOW}Note: This step requires user interaction and may take a few minutes${FMT_RESET}"
# Remove existing pimpmykali folder
rm -rf pimpmykali/ 2>/dev/null

# Clone pimpmykali repository & enter the folder
git clone -q https://github.com/Dewalt-arch/pimpmykali

# Execute the script - keeping stdout for user interaction
sudo pimpmykali/pimpmykali.sh --auto

# Clean up Pimp My Kali
rm -rf pimpmykali/ 2>/dev/null
rm -f pimpmykali.log 2>/dev/null

# Install Oh My Zsh
echo "${FMT_BLUE}•${FMT_RESET} Installing Oh My Zsh... (3/12)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1

# Install required packages
echo "${FMT_BLUE}•${FMT_RESET} Installing packages to make your terminal look better... (4/12)"
sudo apt install -y -qq grc colorize bat tmux curl wget gpg > /dev/null 2>&1

# Install zsh plugins
echo "${FMT_BLUE}•${FMT_RESET} Installing Zsh plugins... (5/12)"
git clone -q https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install eza
echo "${FMT_BLUE}•${FMT_RESET} Installing eza... (6/12)"
sudo mkdir -p /etc/apt/keyrings 2>/dev/null
wget -q -O- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg > /dev/null 2>&1
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt install -y -qq eza > /dev/null 2>&1

# Download tmux config
echo "${FMT_BLUE}•${FMT_RESET} Setting up tmux... (7/12)"
wget -q https://raw.githubusercontent.com/Neosprings/dotfiles/refs/heads/main/.tmux.conf -O ~/.tmux.conf

# Install Nerd Fonts
echo "${FMT_BLUE}•${FMT_RESET} Installing Hack Nerd Font... (8/12)"
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.tar.xz
sudo tar -xf Hack.tar.xz -C /usr/share/fonts 2>/dev/null
sudo rm -f Hack.tar.xz 2>/dev/null

# Install SGPT dependencies
echo "${FMT_BLUE}•${FMT_RESET} Installing SGPT... (9/12)"
echo "${FMT_YELLOW}   This might take some time...${FMT_RESET}"
(pipx install shell-gpt > /dev/null 2>&1) &
spinner $!


# Update the RustScan and Kerbrute installations to use the spinner
echo "${FMT_BLUE}•${FMT_RESET} Installing RustScan... (10/12)"
sudo apt install -y -qq cargo > /dev/null 2>&1
echo "${FMT_YELLOW}   This might also take some time...${FMT_RESET}"
(cargo install rustscan --quiet) &
spinner $!

# For Kerbrute
echo "${FMT_BLUE}•${FMT_RESET} Installing Kerbrute... (11/12)"
git clone -q https://github.com/ropnop/kerbrute.git
cd kerbrute
sed -i 's/ARCHS=.*/ARCHS=arm64/' Makefile
echo "${FMT_YELLOW}   Building Kerbrute...${FMT_RESET}"
(make linux > /dev/null 2>&1) &
spinner $!
sudo mv dist/kerbrute_linux_arm64 /usr/local/bin/kerbrute 2>/dev/null
cd .. && rm -rf kerbrute 2>/dev/null

# Install Ligolo-ng
echo "${FMT_BLUE}•${FMT_RESET} Installing Ligolo-ng... (12/12)"
mkdir ligolo-temp && cd ligolo-temp
wget -q https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz
tar -xf ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz 2>/dev/null
sudo mv proxy /usr/local/bin/ligolo-proxy 2>/dev/null
cd .. && rm -rf ligolo-temp 2>/dev/null

# Brushing up the .zshrc file
echo "${FMT_BLUE}•${FMT_RESET} Finalizing: Updating .zshrc configuration..."
wget -q https://raw.githubusercontent.com/henrykobutra/reARMKali/refs/heads/main/dotfiles/.zshrc -O ~/.zshrc


# Print completion message
print_success() {
  printf '\n'
  printf '\033[38;5;208m                      \n'
  printf '\033[38;5;147m _ _ /\  _ _ |_/ _ |. \n'
  printf '\033[38;5;111m| (-/--\| |||| \(_||| \n'
  printf '\033[38;5;75m                      \n'
  printf "${FMT_RESET}"
  printf '\n'
  echo  "${FMT_BOLD}Next steps:${FMT_RESET}"
  echo  "${FMT_BLUE}•${FMT_RESET} Restart your VM to apply all changes"
  echo  "${FMT_BLUE}•${FMT_RESET} If using SGPT, have your OpenAI API key ready"
  echo  "${FMT_BLUE}•${FMT_RESET} Check out the ${FMT_YELLOW}.zshrc${FMT_RESET} file for further customization"
  echo  "${FMT_BLUE}•${FMT_RESET} Change the terminal font to ${FMT_YELLOW}Hack Nerd Font Mono${FMT_RESET} for better icon support"
  printf '\n'
  echo  "${FMT_BOLD}After restart, you can use:${FMT_RESET}"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}kerbrute${FMT_RESET} - Direct access to Kerbrute tool"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}ligolo-proxy${FMT_RESET} - Start the Ligolo-ng proxy"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}rustscan${FMT_RESET} - Fast port scanner written in Rust"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}sgpt${FMT_RESET} - AI-powered terminal assistant"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}eza${FMT_RESET} - Modern replacement for ls (and ll, and la, btw)"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}bat${FMT_RESET} - Modern replacement for cat (try running cat on a file ...)"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}nmap with colors${FMT_RESET} - Try nmap btw, ... it'll look nicer too!"
  echo  "${FMT_BLUE}•${FMT_RESET} ${FMT_YELLOW}tmux${FMT_RESET} - tmux will now auto start (check .tmux.conf for custom keybinds (ctrl+a) or disable it in .zshrc)"
  printf '\n'
  echo  "${FMT_BOLD}Found this useful? Consider:${FMT_RESET}"
  echo  "${FMT_BLUE}•${FMT_RESET} Following the project: https://github.com/henrykobutra/reARMKali"
  echo  "${FMT_BLUE}•${FMT_RESET} Reporting issues or contributing to the project"
  printf '\n'
}

# Call the success message
print_success