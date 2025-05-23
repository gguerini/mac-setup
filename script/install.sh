#!/bin/zsh

# Logo
LOGO=" __  __               _____      _
|  \/  |             / ____|    | |
| \  / | __ _  ___  | (___   ___| |_ _   _ _ __
| |\/| |/ _\` |/ __|  \___ \ / _ \ __| | | | '_ \\
| |  | | (_| | (__   ____) |  __/ |_| |_| | |_) |
|_|  |_|\__,_|\___| |_____/ \___|\__|\__,_| .__/
                                          | |
                                          |_|"

# Colors
BOLD=$(tput bold)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
DEFAULT=$(tput sgr0)

# New line character
NEW_LINE="\n"
# Horizonal line in cyan color
DIVIDER="${CYAN}${BOLD}------------------------------------------------$DEFAULT"
# Horizonal line in red color
RED_DIVIDER="${RED}${BOLD}------------------------------------------------$DEFAULT"

# Arrows
ARROW="$CYAN$BOLD==>$DEFAULT"
ARROW_GREEN="$GREEN$BOLD==>$DEFAULT"
ARROW_YELLOW="$YELLOW$BOLD==>$DEFAULT"

# Booleans to track if specific programs are already installed
IS_HOMEBREW_INSTALLED=false
IS_OH_MY_ZSH_INSTALLED=false
IS_ITERM_INSTALLED=false

clear

# Print logo and description
echo -e "${CYAN}${BOLD}${LOGO}${DEFAULT}${NEW_LINE}"
echo -e "${CYAN}${BOLD}   Full Stack Development Setup for macOS$NEW_LINE"
echo -e "$DIVIDER"
echo "      <https://github.com/gguerini>"
echo "  <https://github.com/gguerini/mac-setup>"
echo -e "${DIVIDER}${NEW_LINE}"

echo "Welcome to the installer!"
echo -e "First, enter your password to execute all the commands as super user.$NEW_LINE"

echo -e "${RED}${BOLD}Important:$DEFAULT You can be asked more times for password during the process."
echo -e "Also, make sure that You are logged in to the Mac App Store.$NEW_LINE"

# Prompt user for password
sudo -v

clear

#----------------------------
# Homebrew
#----------------------------

if hash brew 2>/dev/null; then
  IS_HOMEBREW_INSTALLED=true
fi

if $IS_HOMEBREW_INSTALLED; then
  echo "${ARROW_GREEN} Homebrew already installed!"

  echo -n "${ARROW_YELLOW} Update Homebrew formulas? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Updating Homebrew formulas..."

    brew update
    brew upgrade
  fi
else
  echo -n "${ARROW_YELLOW} Install Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    IS_HOMEBREW_INSTALLED=true
  fi
fi

#----------------------------
# Basic Dependencies
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  # read -p "${ARROW_YELLOW} Install dependencies (coreutils, curl, openssl and readline) via Homebrew? [y/n]: "
  echo -n "${ARROW_YELLOW} Install dependencies (coreutils, curl, openssl and readline) via Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing dependencies..."
    brew install coreutils curl openssl readline
  fi
fi

#----------------------------
# Git
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  # read -p "${ARROW_YELLOW} Install latest Git version via Homebrew? [y/n]: "
  echo -n "${ARROW_YELLOW} Install latest Git version via Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing Git..."
    brew install git
  fi
fi

#----------------------------
# .gitconfig
#----------------------------

echo -n "${ARROW_YELLOW} Configure Git by creating ~/.gitconfig file? [y/n]: "
read REPLY

if [[ "$REPLY" == "y" ]]; then
  echo -n "${ARROW_YELLOW} Please enter full name: "
  read username
  echo -n "${ARROW_YELLOW} Please enter Git e-mail: "
  read email
  echo -n "${ARROW_YELLOW} Please enter Git editor: "
  read editor
  echo "${ARROW} Creating ~/.gitconfig file..."

  cp ~/.gitconfig ~/.gitconfig.mac_setup_backup 2> /dev/null
  cp .gitconfig ~
  sed -i -e "s/First Last/$username/g" ~/.gitconfig
  sed -i -e "s/email@email.com/$email/g" ~/.gitconfig
  sed -i -e "s/= editor/= $editor/g" ~/.gitconfig
fi

#----------------------------
# Tig
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  echo -n "${ARROW_YELLOW} Install Tig: text-mode interface for Git via Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing Tig..."
    brew install tig
  fi
fi

#----------------------------
# direnv
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  echo -n "${ARROW_YELLOW} Install direnv via Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing direnv..."
    brew install direnv
  fi
fi


#----------------------------
# asdf & ruby-build
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  echo -n "${ARROW_YELLOW} Install asdf & ruby-build via Homebrew? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Installing asdf & ruby-build..."
    brew install asdf
    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
  fi
fi

#----------------------------
# Application bundle
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  echo -n "${ARROW_YELLOW} Install applications via Homebrew Cask and Mac App Store? [y/n]: "
  read REPLY
  # read -r

  if [[ "$REPLY" = "y" ]]; then
    echo -e "${RED}${BOLD}Important: Sign into the Mac App Store GUI app manually. Hit any key to continue. "
    read
    echo "${ARROW} Installing applications..."
    brew bundle
  fi
fi

# ----------------------------
# oh-my-zsh
# ----------------------------

echo -n "${ARROW_YELLOW} Install Oh My Zsh? [y/n]: "
read REPLY

if [[ "$REPLY" == "y" ]]; then
  echo -e "${NEW_LINE}${RED_DIVIDER}"
  echo -e "${RED}${BOLD}Important: After the Oh My Zs installation is done, you will have to 'exit' the new shell to continue this script."
  echo -e "${RED_DIVIDER}${NEW_LINE}"

  echo "${ARROW} Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  IS_OH_MY_ZSH_INSTALLED=true
fi

#----------------------------
# .zshrc
#----------------------------

if $IS_OH_MY_ZSH_INSTALLED; then
  echo -n "${ARROW_YELLOW} Configure Oh My Zsh by creating ~/.zshrc file? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Creating ~/.zshrc file..."
    cp ~/.zshrc ~/.zshrc.mac_setup_backup 2> /dev/null
    cp .zshrc ~
    sed -i -e "s+custom_path+$PWD/oh-my-zsh+g" ~/.zshrc
  fi
fi

#----------------------------
# iTerm2 profile
#----------------------------

if [ -d /Applications/iTerm.app/ ]; then
  IS_ITERM_INSTALLED=true
fi

if $IS_ITERM_INSTALLED; then
  echo -n "${ARROW_YELLOW} Install Dracula iTerm2 profile? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW_YELLOW} New iTerm2 window opened. Go to 'Preferences' > 'Profiles' > 'Colors' and choose 'Dracula' from the 'Color Presets' menu."
    open ./Dracula.itermcolors
  fi
fi

#----------------------------
# Rectangle settings
#----------------------------

if [ -d /Applications/Rectangle.app/ ]; then
  IS_RECTANGLE_INSTALLED=true
fi

if $IS_RECTANGLE_INSTALLED; then
  echo -n "${ARROW_YELLOW} Configure Rectangle settings? [y/n]: "
  read REPLY

  if [[ "$REPLY" == "y" ]]; then
    echo "${ARROW} Configuring Rectangle settings..."
    cp ~/Library/Preferences/com.knollsoft.Rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist.mac_setup_backup 2> /dev/null
    cp -r rectangle.plist ~/Library/Preferences/com.knollsoft.Rectangle.plist 2> /dev/null
  fi
fi

#----------------------------
# Computer name
#----------------------------

echo -n "${ARROW_YELLOW} Set computer name? [y/n]: "
read REPLY

if [[ "$REPLY" == "y" ]]; then
  echo -n "${ARROW_YELLOW} Please enter computer name: "
  read uservar

  sudo scutil --set ComputerName "$uservar"
fi

#----------------------------
# Host name
#----------------------------

echo -n "${ARROW_YELLOW} Set host name? [y/n]: "
read REPLY

if [[ "$REPLY" == "y" ]]; then
  echo -n "${ARROW_YELLOW} Please enter host name (avoid special characters, space, etc.): "
  read uservar

  sudo scutil --set HostName "$uservar"
  sudo scutil --set LocalHostName "$uservar"
fi

#----------------------------
# macOS Defaults
#----------------------------

echo -n "${ARROW_YELLOW} Configure macOS Defaults? [y/n]: "
read REPLY

if [[ "$REPLY" == "y" ]]; then
  echo "${ARROW} Configuring macOS Defaults..."
  echo -e "${NEW_LINE}${DIVIDER}"
  echo -e "${YELLOW}${BOLD}Note:$DEFAULT If you see errors like 'Could not write domain', temporarily give Full Disk Access (System Preferences > Security & Privacy)"
  echo -e "to the Terminal/iTerm app and re-apply macOS Defaults manually: ${CYAN}${BOLD}./script/defaults.sh"
  echo -e "${DIVIDER}"
  . ./script/defaults.sh
fi

echo -e "${NEW_LINE}${YELLOW}${BOLD}Note:$DEFAULT Some changes may need system restart to be applied!"
echo -e "${NEW_LINE}${GREEN}${BOLD}Congratulations, installation complete!${DEFUALT}${NEW_LINE}"

exit 0
