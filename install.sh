#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Start of install
echo -e "${BLUE}Starting Kali setup script...${NC}"

# Update system
echo -e "${GREEN}Updating system packages...${NC}"
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
rm pimpmyali.log

# Install Oh My Zsh
echo -e "${GREEN}Installing Oh My Zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install required packages
echo -e "${GREEN}Installing required packages...${NC}"
sudo apt install -y grc colorize bat tmux curl wget gpg

# Install zsh plugins
echo -e "${GREEN}Installing Zsh plugins...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install eza
echo -e "${GREEN}Installing eza...${NC}"
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt install -y eza

# Download tmux config
echo -e "${GREEN}Downloading tmux config...${NC}"
wget https://raw.githubusercontent.com/Neosprings/dotfiles/refs/heads/main/.tmux.conf -O ~/.tmux.conf

# Install Nerd Fonts
echo -e "${GREEN}Installing Hack Nerd Font...${NC}"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.tar.xz
sudo tar -xf Hack.tar.xz -C /usr/share/fonts 
sudo rm Hack.tar.xz

# Install SGPT dependencies
echo -e "${GREEN}Installing SGPT...${NC}"
pipx install shell-gpt

# Install Cargo and RustScan
sudo apt install -y cargo
cargo install rustscan

# Install Kerbrute
echo -e "${GREEN}Installing Kerbrute...${NC}"
git clone https://github.com/ropnop/kerbrute.git
cd kerbrute
sed -i 's/ARCHS=.*/ARCHS=arm64/' Makefile
make linux
sudo mv dist/kerbrute_linux_arm64 /usr/local/bin/kerbrute
cd .. && rm -rf kerbrute

# Install Ligolo-ng
echo -e "${GREEN}Installing Ligolo-ng...${NC}"
mkdir ligolo-temp && cd ligolo-temp
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz
tar -xvzf ligolo-ng_proxy_0.7.5_linux_arm64.tar.gz
sudo mv proxy /usr/local/bin/ligolo-proxy
cd .. && rm -rf ligolo-temp

# Brushig up the .zshrc file
echo -e "${GREEN}Updating .zshrc configuration...${NC}"
wget 

echo -e "${BLUE}Installation complete! Please perform these manual steps:${NC}"
echo -e "${GREEN}1. Open your terminal preferences and change the font to 'Hack Nerd Font Mono'${NC}"
echo -e "${GREEN}2. Configure your OpenAI API key for SGPT using: sgpt --api-key 'your-key-here'${NC}"
echo -e "${GREEN}3. Log out and log back in, or restart your terminal for all changes to take effect${NC}"

# Reminder about wallpaper
echo -e "${GREEN}Don't forget to set your preferred wallpaper!${NC}"