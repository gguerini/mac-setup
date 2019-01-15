#!/bin/bash

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

# Array of available applications that can be installed via Homebrew Cask
AVAILABLE_CASK_APPLICATIONS=(alfred amazon-music appcleaner bitbar dropbox firefox github google-chrome postman postico sequel-pro slack spectacle transmission iterm2 imageoptim 1password sublime-text visual-studio-code vlc spotify)

# Array of available npm packages
AVAILABLE_NPM_PACKAGES=(gulp-cli jest live-server create-react-app)

# Array of available VS Code extensions
AVAILABLE_VSCODE_EXTENSIONS=(CoenraadS.bracket-pair-colorizer PKief.material-icon-theme alefragnani.project-manager christian-kohler.path-intellisense dbaeumer.vscode-eslint formulahendry.auto-rename-tag mrmlnc.vscode-scss msjsdiag.debugger-for-chrome techer.open-in-browser aaron-bond.better-comments kamikillerto.vscode-colorize christian-kohler.npm-intellisense)

# Arrays of applications/packages/extensions selected by user (empty by default)
SELECTED_CASK_APPLICATIONS=()
SELECTED_NPM_PACKAGES=()
SELECTED_VSCODE_EXTENTIONS=()

# Booleans to track if specific programs are already installed
IS_HOMEBREW_INSTALLED=false
IS_MAS_INSTALLED=false
IS_NVM_INSTALLED=false
IS_OH_MY_ZSH_INSTALLED=false
IS_NODE_INSTALLED=false
IS_VSCODE_INSTALLED=false
IS_ITERM_INSTALLED=false
IS_SUBLIME_TEXT_INSTALLED=false

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
  echo "${ARROW} Updating Homebrew formulas..."

  brew update
  brew upgrade
else
  read -ep "${ARROW_YELLOW} Install Homebrew? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    IS_HOMEBREW_INSTALLED=true
  fi
fi

#----------------------------
# Git
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  read -p "${ARROW_YELLOW} Install latest Git version via Homebrew? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Git..."
    brew install git
  fi
fi

#----------------------------
# .gitconfig
#----------------------------

read -p "${ARROW_YELLOW} Configure Git by creating ~/.gitconfig file? [y/n]: "

if [ "$REPLY" == "y" ]; then
  read -p "${ARROW_YELLOW} Please enter full name: " username
  read -p "${ARROW_YELLOW} Please enter Git e-mail: " email
  read -p "${ARROW_YELLOW} Please enter Git editor: " editor
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
  read -p "${ARROW_YELLOW} Install Tig: text-mode interface for Git via Homebrew? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing Tig..."
    brew install tig
  fi
fi

#----------------------------
# rbenv & ruby-build
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  read -p "${ARROW_YELLOW} Install rbenv & ruby-build via Homebrew? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Installing rbenv & ruby-build..."
    brew install rbenv ruby-build
  fi
fi

#----------------------------
# Application bundle
#----------------------------

if $IS_HOMEBREW_INSTALLED; then
  read -p "${ARROW_YELLOW} Install applications via Homebrew Cask? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    for item in "${AVAILABLE_CASK_APPLICATIONS[@]}"; do
      read -ep "${ARROW_YELLOW} Install \"$item\"? [y/n]: "
      if [ "$REPLY" == "y" ]; then
      SELECTED_CASK_APPLICATIONS+=("$item")
      fi
    done  

    if [ ${#SELECTED_CASK_APPLICATIONS[@]} -gt 0 ]; then
      echo "${ARROW} Installing applications via Homebrew Cask..."
      for application in "${SELECTED_CASK_APPLICATIONS[@]}"; do
        brew cask install ${application}
      done
    fi
  fi
fi

#----------------------------
# oh-my-zsh
#----------------------------

read -p "${ARROW_YELLOW} Install Oh My Zsh? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo -e "${NEW_LINE}${RED_DIVIDER}"
  echo -e "${RED}${BOLD}Important: After the Oh My Zs installation is done, you will have to 'exit' the new shell to continue this script."
  echo -e "${RED_DIVIDER}${NEW_LINE}"

  echo "${ARROW} Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  IS_OH_MY_ZSH_INSTALLED=true
fi

#----------------------------
# .zshrc
#----------------------------

if $IS_OH_MY_ZSH_INSTALLED; then
  read -p "${ARROW_YELLOW} Configure Oh My Zsh by creating ~/.zshrc file? [y/n]: "

  if [ "$REPLY" == "y" ]; then
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
  read -p "${ARROW_YELLOW} Install Dracula iTerm2 profile? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW_YELLOW} New iTerm2 window opened. Go to 'Preferences' > 'Profiles' > 'Colors' and choose 'Dracula' from the 'Color Presets' menu."
    open ./Dracula.itermcolors
  fi
fi

# TEMPORARILY DISABLED 
#----------------------------
# Node Version Manager
#----------------------------

# if ! [ -x "$(command -v nvm)" ]; then
#   IS_NVM_INSTALLED=true
# fi

# if $IS_NVM_INSTALLED; then
#   echo "${ARROW_GREEN} Node Version Manager already installed!"
# else
#   read -p "${ARROW_YELLOW} Install nvm (Node Version Manager)? [y/n]: "

#   if [ "$REPLY" == "y" ]; then
#     echo "${ARROW} Installing Node Version Manager..."
#     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
#     source ~/.bash_profile

#     IS_NVM_INSTALLED=true
#   fi
# fi

# TEMPORARILY DISABLED 
#----------------------------
# VS Code extensions
#----------------------------

# if hash code 2>/dev/null; then
#   IS_VSCODE_INSTALLED=true
# fi

# if $IS_VSCODE_INSTALLED; then
#   read -p "${ARROW_YELLOW} Install Visual Studio Code extensions? [y/n]: "

#   if [ "$REPLY" == "y" ]; then
#     for item in "${AVAILABLE_VSCODE_EXTENSIONS[@]}"; do
#       read -ep "${ARROW_YELLOW} Install \"$item\"? [y/n]: "
#       if [ "$REPLY" == "y" ]; then
#       SELECTED_VSCODE_EXTENSIONS+=("$item")
#       fi
#     done  

#     if [ ${#SELECTED_VSCODE_EXTENSIONS[@]} -gt 0 ]; then
#       echo "${ARROW} Installing Visual Studio Code extensions..."
#       for application in "${SELECTED_NPM_PACKAGES[@]}"; do
#         code --install-extension ${application}
#       done
#     fi

#   fi
# fi

# TEMPORARILY DISABLED 
#----------------------------
# VS Code settings
#----------------------------

# if $IS_VSCODE_INSTALLED; then
#   read -p "${ARROW_YELLOW} Configure Visual Studio Code settings? [y/n]: "

#   if [ "$REPLY" == "y" ]; then
#     echo "${ARROW} Configuring Visual Studio Code settings..."
#     cp settings.json /Users/${USER}/Library/Application\ Support/Code/User
#   fi
# fi

# TEMPORARILY DISABLED 
#----------------------------
# VS Code snippets
#----------------------------

# if $IS_VSCODE_INSTALLED; then
#   read -p "${ARROW_YELLOW} Configure Visual Studio Code snippets? [y/n]: "

#   if [ "$REPLY" == "y" ]; then
#     echo "${ARROW} Configuring Visual Studio Code snippets..."
#     cp snippets.code-snippets /Users/${USER}/Library/Application\ Support/Code/User/snippets
#   fi
# fi

#----------------------------
# Sublime Text
#----------------------------

if [ -d /Applications/Sublime\ Text.app/ ]; then
  IS_SUBLIME_TEXT_INSTALLED=true
fi

if $IS_SUBLIME_TEXT_INSTALLED; then
  read -p "${ARROW_YELLOW} Install Sublime Text settings? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User ]; then
      echo "${ARROW} Installing Sublime Text settings..."
      rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
      ln -s $PWD/sublime-text/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages
    else
      echo "${RED}${BOLD}Note:$DEFAULT You need to open Sublime Text at least once before installing the settings."
      echo "While you are there, install the Package Control for better results. Then, re-apply this script!"
    fi
  fi
fi

#----------------------------
# Spectacle shortcuts
#----------------------------

if [ -d /Applications/Spectacle.app/ ]; then
  IS_SPECTACLE_INSTALLED=true
fi

if $IS_SPECTACLE_INSTALLED; then
  read -p "${ARROW_YELLOW} Configure Spectacle shortcuts? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    echo "${ARROW} Configuring Spectacle shortcuts..."
    cp -r spectacle.json ~/Library/Application\ Support/Spectacle/Shortcuts.json 2> /dev/null
  fi
fi

#----------------------------
# Firmware password
#----------------------------

if [[ $(sudo firmwarepasswd -check) =~ "Password Enabled: Yes" ]]; then
  echo "${ARROW_GREEN} Firmware password is already set up!"
else 
  read -p "${ARROW_YELLOW} Set up firmware password? [y/n]: "

  if [ "$REPLY" == "y" ]; then
    sudo firmwarepasswd -setpasswd -setmode command
  fi
fi

#----------------------------
# Computer name
#----------------------------

read -p "${ARROW_YELLOW} Set computer name? [y/n]: "

if [ "$REPLY" == "y" ]; then
  read -p "${ARROW_YELLOW} Please enter computer name: " uservar

  sudo scutil --set ComputerName $uservar
  sudo scutil --set HostName $uservar
  sudo scutil --set LocalHostName $uservar
fi

#----------------------------
# macOS Defaults
#----------------------------

read -p "${ARROW_YELLOW} Configure macOS Defaults? [y/n]: "

if [ "$REPLY" == "y" ]; then
  echo "${ARROW} Configuring macOS Defaults..."
  echo -e "${NEW_LINE}${DIVIDER}"
  echo -e "${YELLOW}${BOLD}Note:$DEFAULT If you see errors like 'Could not write domain', temporarily give Full Disk Access (System Preferences > Security & Privacy)"
  echo -e "to the Terminal/iTerm app and re-apply macOS Defaults manually: ${CYAN}${BOLD}./script/defaults.sh"
  echo -e "${DIVIDER}"
  . ./script/defaults.sh
fi

echo -e "${NEW_LINE}${YELLOW}${BOLD}Note:$DEFAULT Some changes may need system restart to be applied!"
echo -e "${NEW_LINE}${GREEN}${BOLD}Congratulations, installation complete!${DEFUALT}${NEW_LINE}"

exit 1
