#!/bin/bash

# Define colors
RED='\033[0;31m'
WHITE='\033[0;37m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

clear

# Check if Git is installed
if ! command -v git &> /dev/null
then
 echo -e "${RED}[ERROR]${NC} => Git could not be found. Install git before this."
 exit
fi

. /etc/os-release

if [ "$ID" = "arch" ]; then
   read -p "looks like you are on arch linux. would you like to install jetbrains nerd font? (yes/no) " response
   case "$response" in
    [yY][eE][sS]|[yY]) 
        sudo pacman -S ttf-jetbrains-mono-nerd
     ;;
 *)
     echo -e "${RED}Skipping nerd font installation...${NC}"
     clear
     ;;
    esac
fi

echo -e "${WHITE}The Script will open neovim to install plugins. ${RED} after installation was done, quit using :qa command${NC}"

#  Backup Operation
if [ -d ~/.config/nvim ]; then
 echo -e "${GREEN}-==Backup Operation==-${NC}"
 # Ask user if they want to create a backup
 read -p "Do you want to create a backup of your current .config/nvim directory? (yes/no) " response
 case "$response" in
  [yY][eE][sS]|[yY])
    # Check if the backup directory exists
    if [ ! -d ~/.config/nvim-backup ]; then
     mkdir ~/.config/nvim-backup
    fi
    # Create a timestamped backup of the .config/nvim directory
    timestamp=$(date +%Y%m%d-%H%M%S)
    mv ~/.config/nvim ~/.config/nvim-backup/$timestamp
    ;;
  *)
    echo -e "${WHITE}Skipping backup...${NC}"
    ;;
 esac
fi

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# Install NvChad
echo -e "${GREEN}-==Installing NvChad ...==-${NC}"
git clone https://github.com/NvChad/starter ~/.config/nvim --depth 1

#  Copying Files
echo -e "${GREEN}-==Copying Files==-${NC}"
rsync -av --exclude='README.md' --exclude='.git/' --exclude='install.sh' . ~/.config/nvim/lua/

nvim "+Lazy! sync" "+qa"
nvim "+MasonInstall clangd clang-format codelldb lua-language-server tree-sitter-cli"
