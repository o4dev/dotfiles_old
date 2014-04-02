#
#
#    ----------------------------------------------------------------------------------------------------
#       ▄    ▄                                                  █                                   ▀▄   
#       ██  ██ ▄   ▄                              ▄▄▄▄▄   ▄▄▄   █ ▄▄    ▄ ▄▄   ▄▄▄                   ▀▄  
#       █ ██ █ ▀▄ ▄▀                                 ▄▀  █   ▀  █▀  █   █▀  ▀ █▀  ▀           █       █  
#       █ ▀▀ █  █▄█                                ▄▀     ▀▀▀▄  █   █   █     █                       █  
#       █    █  ▀█                           █    █▄▄▄▄  ▀▄▄▄▀  █   █   █     ▀█▄▄▀           █      █   
#               ▄▀                                                                                  ▀    
#              ▀▀   
#    ----------------------       ((((())  --------------------------------------------------------------
#                               ((('_  _`)  
#                               ((G   \ |)                         
#                              (((`   " ,
#                               .((\.:~:          .--------------.
#                               __.| `"'.__      | \              |
#                            .''   `---'   `.    |  .             :
#                           /                `   |   `-.__________)
#                          |             ~       |  :             :
#                          |                     |  :  |
#                          |    _                |     |   [ ##   :
#                           \    `--.        ____|  ,   oo_______.'
#                            `_   ( \) _____/     `--___
#                            | `--)  ) `-.   `---   ( - a:f -
#                            |   '///`  | `-.
#                            |     | |  |    `-.
#                            |     | |  |       `-.
#                            |     | |\ |
#                            |     | | \|
#                             `-.  | |  |
#                                `-| '
#


# oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="af-magic-mod"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# (plugins can be found in ~/.oh-my-zsh/plugins/*, ~/.oh-my-zsh/custom/plugins/)
plugins=(git git-extras pip virtualenv themes)

source $ZSH/oh-my-zsh.sh

# framebuffer resolution fix
if ((!$+DISPLAY)); then
    fbset -g 1920 1080 1920 1080 32
fi

export PATH=$PATH:~/bin

#=== FUNCTION ================================================================
# NAME: aliasrc
# DESCRIPTION: Acts like alias but also adds alias to end of this file.
#=============================================================================
aliasrc(){
    echo $@ | sed 's/^/alias /;s/=/="/;s/$/"/' >> ~/.zshrc
    source ~/.zshrc
}

#=== FUNCTION ================================================================
# NAME: back
# DESCRIPTION: Runs function in background redirecting all output to /dev/null.
#=============================================================================
back(){ nohup $@ >/dev/null 2>&1 & disown }

#=== FUNCTION ================================================================
# NAME: extract
# DESCRIPTION: Extract any format easily
#=============================================================================
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        NAME=${1%.*}
        mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

#=== FUNCTION ================================================================
# NAME: youtube
# DESCRIPTION: Play youtube from terminal.
#=============================================================================
youtube(){
    if [[ -z "$@" ]]; then
        echo >&2 "You must supply an argument!"
        exit 1
    fi
    mpv -cookies -cookies-file $HOME/tmp/ytcookie.txt $(youtube-dl -g --cookies $HOME/tmp/ytcookie.txt "$1") ${@:2}
}
youtube-music(){
    youtube $@ -vo null
}
youtube-list(){
    for url in "$@"; do youtube-music $url; done
}
youtube-playlist(){
    mpv -vo null $(youtube-dl -g www.youtube.com/view_play_list\?p=$1)
}

subl(){
    nohup /usr/bin/subl $@ >/dev/null 2>&1 &
}

function mkcd(){
    mkdir $@
    cd $@
}

setopt auto_cd
cdpath=($HOME/Documents/Alevels $HOME/Projects)

## below are alias generated by aliasrc

alias activate="source .env/bin/activate"
alias copy="xclip -sel clip"
alias pyinit="touch __init__.py"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias apt="sudo apt-get"
alias apti="apt install"
alias aptup="apt update"
alias aptupi="aptup && apti"
alias aptadd="sudo add-apt-repository"
alias aptaddupi='printf "Repo: " && aptadd $(head -1) && printf "Package: " && aptupi $(head -1)'

alias opentmux="(tmux ls | grep -vq attached && tmux at) || tmux"
alias suspend="sudo bash -c 'pm-suspend & gnome-screensaver-command -l'"
alias suspend="sudo echo && sudo pm-suspend & gnome-screensaver-command -l"
alias netflix="back chromium-browser --app=http://netflix.com"
alias makepas="fpc -Mdelphi"

