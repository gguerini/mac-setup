# zsh / oh-my-zsh
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias reload!="source ~/.zshrc"

alias gamd="git commit -a --amend --reuse-message=HEAD"
alias gwip="git add -u && git commit -m 'WIP'"
alias gundo="reset HEAD~1 --mixed"
alias greb="git fetch && git rebase -i origin/master"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

alias cop="bundle exec rubocop"
