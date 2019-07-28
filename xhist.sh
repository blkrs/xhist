preexec () { :; }

preexec_invoke_exec () {
    dir=`pwd`
    wholedir="$HOME/.xhist$dir"
    mkdir -p $wholedir
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
    local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
    preexec "$this_command"
    echo $this_command >> "$wholedir/history"
}

xhist () {
    dir=`pwd`
    echo "Directory: $dir"
    wholedir="$HOME/.xhist$dir"
    if [ "$1" != "" ]; then
      cat $wholedir/history|grep $1
    else
      cat $wholedir/history
    fi
}

trap 'preexec_invoke_exec' DEBUG


bind '"\e[1;5A":"\C-k \C-uxhist \C-y\n"'
bind '"\e[1;5B":"\C-k \C-uxhist \C-y\n"'
