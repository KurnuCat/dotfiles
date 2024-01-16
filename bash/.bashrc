# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# auto cd
shopt -s autocd

alias anki='QT_QPA_PLATFORM=xcb anki'
alias crypto='curl rate.sx'
alias wtrh='curl wttr.in/'
alias ffmpegrecord='ffmpeg -video_size 1024x768 -framerate 25 -f x11grab -i :0.0+100,200 -f pulse -ac 2 -i default output.mp4'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -vI'
alias rsync='rsync -vrPlu'
alias mkd='mkdir -pv'
alias ytt='yt-dlp --skip-download --write-thumbnail'
alias ffmpeg='ffmpeg -hide_banner'
alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias p='yay'
alias d='sudo dnf'
alias a='sudo apt'
alias autoremove-pacman='sudo pacman -Rs $(pacman -Qtdq)'
alias yt='yt-dlp --embed-metadata -i'
alias yta='yt-dlp -x -f bestaudio/best'
alias nb='newsboat'
alias e='$EDITOR'
alias v='$EDITOR'
alias g='git'
alias sdn='shutdown -h now'
alias ka='killall'
alias z='zathura'

PS1='[\u@\h \W]\$ '
