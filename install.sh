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
rm pimpmykali.log

# Install Oh My Zsh
echo -e "${GREEN}Installing Oh My Zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

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