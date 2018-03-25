# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ser="grep -rnw ./ -e"
alias serpy="grep --include=\*.py -rnw ./ -e"

alias psef='/bin/ps -N --ppid 2 -fH'
alias pogoda='curl wttr.in/~Szerzyny?lang=pl'

#GIT aliases
alias gd='git log -p '
alias gpo='git push origin '
alias gs='git status'
alias gco='git checkout'
alias gcm='git commit -a -m'
alias gmer='git merge'
alias gb='git branch'
alias last5='git log --oneline --decorate -n 5'
alias lg='git log graph format=’%C\(yellow bold\)%h%Creset %C\(bold blue white\)%d%Creset %C\(white bold\)%s%Creset%n %C\(magenta bold\)%cr%Creset %C\(green bold\)%an%Creset'