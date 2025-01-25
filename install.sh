#!/bin/sh

# Define color formatting
FMT_GREEN='\033[0;32m'
FMT_BLUE='\033[0;34m'
FMT_YELLOW='\033[0;33m'
FMT_BOLD='\033[1m'
FMT_RESET='\033[0m'

# Print initial warning and get confirmation
print_warning() {
    printf '\n'
    printf "${FMT_BLUE}"
    printf '                      \n'
    printf ' _ _ /\  _ _ |_/ _ |. \n'
    printf '| (-/--\| |||| \(_||| \n'
    printf '                      \n'
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
echo "${FMT_BLUE}•${FMT_RESET} Starting Kali setup script..."

# Update system
echo "${FMT_BLUE}•${FMT_RESET} Updating system packages..."
sudo apt update

# Pimp My Kali https://github.com/Dewalt-arch/pimpmykali

# Remove existing pimpmykali folder
rm -rf pimpmykali/

# Clone pimpmykali repository & enter the folder
git clone https://github.com/Dewalt-arch/pimpmykali

# Execute the script - For a new Kali VM, run menu option 'N'
# (The script must be run with root privileges)
sudo pimpmykali/pimpmykali.sh --auto

# Clean up Pimp My Kali
rm -rf pimpmykali/

# Comment line below
rm -f pimpmykali.log

# Install Oh My Zsh
echo "${FMT_BLUE}•${FMT_RESET} Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install required packages
echo "${FMT_BLUE}•${FMT_RESET} Installing required packages..."
sudo apt install -y grc colorize bat tmux curl wget gpg

# Install zsh plugins
echo "${FMT_BLUE}•${FMT_RESET} Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install eza
echo "${FMT_BLUE}•${FMT_RESET} Installing eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt install -y eza

# Download tmux config
echo "${FMT_BLUE}•${FMT_RESET} Downloading tmux config..."
wget https://raw.githubusercontent.com/Neosprings/dotfiles/refs/heads/main/.tmux.conf -O ~/.tmux.conf

# Install Nerd Fonts
echo "${FMT_BLUE}•${FMT_RESET} Installing Hack Nerd Font..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.tar.xz
sudo tar -xf Hack.tar.xz -C /usr/share/fonts 
sudo rm Hack.tar.xz

# Install SGPT dependencies
echo "${FMT_BLUE}•${FMT_RESET} Installing SGPT..."
pipx install shell-gpt

# Install Cargo and RustScan
sudo apt install -y cargo
cargo install rustscan

# Install Kerbrute
echo "${FMT_BLUE}•${FMT_RESET} Installing Kerbrute..."
git clone https://github.com/ropnop/kerbrute.git
cd kerbrute
sed -i 's/ARCHS=.*/ARCHS=arm64/' Makefile
make linux
sudo mv dist/kerbrute_linux_arm64 /usr/local/bin/kerbrute
cd .. && rm -rf kerbrute

# Install Ligolo-ng
echo "${FMT_BLUE}•${FMT_RESET} Installing Ligolo-ng..."
mkdir ligolo-temp && cd ligolo-temp
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz
tar -xvzf ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz
sudo mv proxy /usr/local/bin/ligolo-proxy
cd .. && rm -rf ligolo-temp

# Brushig up the .zshrc file
echo "${FMT_BLUE}•${FMT_RESET} Updating .zshrc configuration..."
wget https://raw.githubusercontent.com/henrykobutra/reARMKali/refs/heads/main/dotfiles/.zshrc -O ~/.zshrc

# Define color formatting
FMT_GREEN='\033[0;32m'
FMT_BLUE='\033[0;34m'
FMT_YELLOW='\033[0;33m'
FMT_BOLD='\033[1m'
FMT_RESET='\033[0m'

# Print completion message
print_success() {
  printf '\n'
  printf "${FMT_BLUE}"
  printf '                      \n'
  printf ' _ _ /\  _ _ |_/ _ |. \n'
  printf '| (-/--\| |||| \(_||| \n'
  printf '                      \n'
  printf "${FMT_RESET}"
  printf '\n'
  echo  "${FMT_BOLD}Next steps:${FMT_RESET}"
  echo  "${FMT_BLUE}•${FMT_RESET} Restart your VM to apply all changes"
  echo  "${FMT_BLUE}•${FMT_RESET} If using SGPT, have your OpenAI API key ready"
  echo  "${FMT_BLUE}•${FMT_RESET} Check out the ${FMT_YELLOW}.zshrc${FMT_RESET} file for further customization"
  echo  "${FMT_BLUE}•${FMT_RESET} Change the terminal font to ${FMT_YELLOW}Hack Nerd Font Mono${FMT_RESET} for better icon support"
  printf '\n'
  echo  "${FMT_BOLD}Found this useful? Consider:${FMT_RESET}"
  echo  "${FMT_BLUE}•${FMT_RESET} Following the project: https://github.com/henrykobutra/reARMKali"
  echo  "${FMT_BLUE}•${FMT_RESET} Reporting issues or contributing to the project"
  printf '\n'
}

# Call the success message
print_success