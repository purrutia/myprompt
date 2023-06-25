PROMPT_LONG=40

__ps1() {

  local P='$' # Prompt

  # ANSI Escape colors
  # Black       0;30     Dark Gray     1;30
  # Blue        0;34     Light Blue    1;34
  # Green       0;32     Light Green   1;32
  # Cyan        0;36     Light Cyan    1;36
  # Red         0;31     Light Red     1;31
  # Purple      0;35     Light Purple  1;35
  # Brown       0;33     Yellow        1;33
  # Light Gray  0;37     White         1;37
  #                      Following text needs to be reseted

  local r='\[\e[31m\]'    # root color
  local g='\[\e[30m\]'    # graphics color
  local h='\[\e[34m\]'    # hostname color
  local u='\[\e[33m\]'    # username color
  local p='\[\e[33m\]'    # prompt color
  local w='\[\e[32m\]'    # workpath color
  local b='\[\e[36m\]'    # git branch color
  local x='\[\e[0m\]'     # reset color

  local dir;
  local B=$(git branch --show-current 2>/dev/null)


  if [ $EUID -eq 0 ]; then
    P='#'
    u=$r
    p=$u
  fi

  if [ "${PWD}" = "$HOME" ]; then
    dir='~'
  else
    dir="${PWD}"
  fi

  local countme="$USER@$(hostname):$dir($B)\$ "

  if [ $B ]; then
    B="$g ($b$B$g)"
  fi

  local short="$u\u$x$g@$h\h$g:$w$dir$B$p$P$x "
  local long="$g╔ $u\u$x$g@$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  local double="$g╔ $u\u$x$g@$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "


  if [ "${#countme}" -gt "${PROMPT_LONG}" ]; then
    PS1="$long"
  else
    PS1="$short"
  fi

}

PROMPT_COMMAND="__ps1"
