# Sets reasonable OS X defaults.
# https://macos-defaults.com/
#
# Run ./defaults.sh and you'll be good to go.

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Finder                                                                      #
###############################################################################

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable showing tags
defaults write com.apple.finder ShowRecentTags -int 0

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Show favorites bar in Safari by default
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Shoe Safari’s status bar
defaults write com.apple.Safari ShowOverlayStatusBar -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

###############################################################################
# Dock, Dashboard                                                             #
###############################################################################

# Set Dock size
defaults write com.apple.dock tilesize -int 35

# Auto-hide Dock
defaults write com.apple.dock autohide -int 1

# Disable animations
defaults write com.apple.dock launchanim -int 0

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -int 1

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Trackpad.                                                                   #
###############################################################################

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# Enable right click (tap with two fingers)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1

# Enable application change (swipe horizontal witch three fingers)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

# Enable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 1

# Enable Expose gesture (slide down with three fingers)
defaults write com.apple.dock showAppExposeGestureEnabled -int 1

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Set a really fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Appearance                                                                  #
###############################################################################

# Enable Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# Set appearance color to graphite
defaults write -g AppleAccentColor -integer 4

###############################################################################
# Other stuff                                                                 #
###############################################################################

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Text, spell checker automatically identifies languages
defaults write NSGlobalDomain NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Ask to keep change when closing documents
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true

# Set alert sound
# defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Funk.aiff"

# Play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

applications_to_kill=(
  "Activity Monitor"
  "Dock"
  "Finder"
)

killall "${applications_to_kill[@]}"
