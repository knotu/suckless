# source bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

source /etc/profile
source /usr/share/bash-completion/bash_completion
source $HOME/.bash_dir_aliases 
eval "`dircolors -b ~/.dircolors.ansi-universal`"

PATH=$PATH:$HOME/bin

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export EDITOR=nano

## colors ## 
blue="\033[1;34m"
cyan="\[\033[1;36m\]"      
green="\033[1;32m"
red="\033[1;31m"
bold="\033[1;37m"
reset="\033[0m"

#set completion-ignore-case on
#set completion-display-width 1

# history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Check for an interactive session
#[ -z "$PS1" ] && return

complete -cf sudo

#PS1='[\u@\h \W]\$ '
#PS1='┌─[\d \A]-[\033[1;33m\u\033[0m][\W]\n\[\e[0m\]└─> '
PS1='┌─[\d \A]-[\033[1;36m\h\033[0m][\w]\n\[\e[0m\]└─> '

####################### Shell Options #######################

shopt -s autocd # cd to a dir just by typing its name
PROMPT_COMMAND='[[ ${__new_wd:=$PWD} != $PWD ]] && ls -CF;__new_wd=$PWD' # ls after cding

shopt -s checkwinsize               	# update the value of LINES and COLUMNS after each command if altered
shopt -s cdspell                    		# autocorrects cd misspellings
shopt -s cmdhist                    		# save multi-line commands in history as single line
shopt -s dotglob                    		# include dotfiles in pathname expansion
shopt -s expand_aliases             	# expand aliases
shopt -s extglob                    		# enable extended pattern-matching features
shopt -s nocaseglob                 	# pathname expansion will be treated as case-insensitive
shopt -s histappend                 	# Append History instead of overwriting file.
shopt -s no_empty_cmd_completion # No empty completion

####################### Aliases #######################

# cd
alias back='cd $OLDPWD'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# ls 
alias ls='ls -a -CF --color=auto -h --group-directories-first'
alias ll='ls -AlhGrti'
alias ldate='ls -ltr' # sort by date

# remove/copy/move
alias cpi='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# pacman(yay) 
alias mirror='sudo reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias install='yay -S'
alias orphand='pacman -Qdt'
alias pacfind='yay -Ss'
alias pacinfo='yay -Si'
alias update='yay -Syu'
alias pkglist='pacman -Qqe | grep -v "$(pacman -Qmq)" > pkglist.txt'
alias remove='sudo pacman -Rs'

# system
alias dh='df -h'
alias dsize='du -hx --max-depth=1 | sort -h'
alias edit='scite '
alias grep='grep --color=auto'
alias herp='history | grep'
alias mkdir='mkdir -p'
alias nuke='pkill -9'
alias pid-get='ps aux | grep '
alias reload='source ~/.bashrc'
alias shred='shred -u -v -z '
alias sudo='sudo '
alias window='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'
alias q='exit'

# power 
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias shutdown='sudo systemctl shutdown'

# convert h265 to h264
alias convertmkv='for i in *.mkv; do ffmpeg -i "$i" -c:a copy -c:v copy "${i%.*}.mp4"; done'

# app
#alias atmux='tmux attach -d'
alias mocp='mocp -T black_red_white'
alias mpc='mpv --loop=inf '
alias myserver='python -m http.server 8080'
alias view='~/bin/sxiv -b -f -s f *.{jpg,gif,png,bmp,webp} > /dev/null 2>&1'
alias wget='wget -c '

# weechat w/ dtach
alias irc='dtach -c /tmp/dtach.weechat weechat-curses -d ~/.weechat'
alias attach='dtach -a /tmp/dtach.weechat'

# newsboat w/ dtach
alias nb='dtach -c /tmp/dtach.newsboat newsboat -r'
alias nba='dtach -a /tmp/dtach.newsboat'

####################### Functions #######################

# create an alias for a directory
function b() {
    echo "alias $1='cd \"$PWD\"'" >> ~/.bash_dir_aliases
}

# backup a file with a date.
bufd () { cp $1 ${1}-`date +%Y%m%d%H%M`.backup ; }

# finds directory sizes and lists them
dirsize ()
{
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
    egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
mktxz() { tar -c --xz -f "${1%%/}.tar.xz" "${1%%/}/"; }

#make dir then cd into it
mkcd (){
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

# screenshot
  shot ()
{
#import -frame -strip -quality 75 "$HOME/$(date +%s).png"
sleep 5;imlib2_grab "/media/data/photos/screenshots/screenshot-$(date +%s).png"
}



