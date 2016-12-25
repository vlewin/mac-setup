#!/bin/bash

# Application setup
tput setaf 4; echo "*** Iterm2 setup"
brew install Caskroom/cask/iterm2

ITERM_SHELL_INTEGRATION=.iterm2_shell_integration.zsh

if [ -f $ITERM_SHELL_INTEGRATION ]; then
  tput setaf 3; echo "<< Skip iTerms2 shell integration installation"
else
  tput setaf 2; echo ">> Install iTerm shell integration"
  curl -L https://iterm2.com/misc/install_shell_integration.sh | bash
fi

tput setaf 4; echo "*** ZSH setup"
brew install zsh zsh-completions
brew install zsh-syntax-highlighting

OH_MY_ZSH=.oh-my-zsh
if [ -d $OH_MY_ZSH ]; then
  tput setaf 3; echo "<< Skip Oh my ZSH installation"
else
  tput setaf 2; echo ">> Install oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

tput setaf 4; echo "*** .inputrc setup"
INPUTRC=~/.inputrc
if [ -f $INPUTRC ]; then
  tput setaf 3; echo "<< Skip $INPUTRC setup"
else
tput setaf 2; echo ">> Install .inputrc modifications"
cat <<-EOT >> $INPUTRC
"\e[A": history-search-backward
"\e[B": history-search-forward
"\e[C": forward-char
"\e[D": backward-char
set show-all-if-ambiguous on
set completion-ignore-case on
TAB: menu-complete
EOT
fi

tput setaf 4; echo "*** Atom setup"
brew install  Caskroom/cask/atom

apm install autocomplete-paths language-vue pigments vue-autocomplete

tput setaf 4; echo "*** Additional applications"
brew cask install appcleaner
brew cask install coconutbattery
brew cask install liteicon
brew cask install github-desktop
brew cask install the-unarchiver
brew cask install telegram-desktop

# System optimizations
tput setaf 4; echo '*** System optimizations'
tput setaf 2; echo '>> Speed Up Animation Speed of Hiding & Displaying the Mac OS X Dock'
defaults write com.apple.dock autohide-time-modifier -float 0.12
# defaults delete com.apple.dock autohide-time-modifier

tput setaf 2; echo '>> Speed Up Mission Control Animations'
defaults write com.apple.dock expose-animation-duration -float 0.15
# defaults delete com.apple.dock expose-animation-duration

tput setaf 2; echo '>> Disable Spaces Animation'
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
# defaults write com.apple.dock workspaces-swoosh-animation-off -bool NO

tput setaf 2; echo '>> Restart Dock ...'
killall Dock

tput setaf 2; echo '>> Unload Mac OS deamons'
tput setaf 7;
launchctl unload /System/Library/LaunchAgents/com.apple.gamed.plist
launchctl unload /System/Library/LaunchAgents/com.apple.PhotoLibraryMigrationUtility.XPC.plist
launchctl unload /System/Library/LaunchAgents/com.apple.cloudphotosd.plist
launchctl unload /System/Library/LaunchAgents/com.apple.icloud.fmfd.plist
