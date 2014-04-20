# af-magic-mod.zsh-theme
#
# Modified version of: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
#
#
# Mainly adds venv support.
#



if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

isenv(){
	[ "$VIRTUAL_ENV" ] && echo "(venv)"
}

# primary prompt

DATE='%H:%M:%S'

showDate(){
    [[ ${#DATE}+3 -lt $COLUMNS ]] && return $?
}
prompt(){
    printf -%.0s {1..${$((($COLUMNS-$(showDate && echo ${#DATE} || echo 0 )) * $1))%.*}}
}

PROMPT='\
$FG[237]`prompt 0.7`\
$fg[cyan]`showDate && date +$DATE`\
$FG[237]`prompt 0.2`\

%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'


# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# right prompt
RPROMPT='$my_orange`[ "$VIRTUAL_ENV" ] && echo "(venv)"`%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$FG[075]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%}"

