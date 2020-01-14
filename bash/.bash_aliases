#!/bin/bash

alias ls='ls --color=auto'
export hsdev="/home/jonty/Documents/Study/Assignments/Y2/FuncProg/"
export hsgit="/home/jonty/Documents/Git/fp-learning-2019-2020/"
export cdev="/home/jonty/Documents/Study/Assignments/Y2/SysProg/"
export sshtw="jxr814@tinky-winky.cs.bham.ac.uk"
alias hsdev="cd /home/jonty/Documents/Study/Assignments/Y2/FuncProg/"
alias hsgit="cd /home/jonty/Documents/Git/fp-learning-2019-2020/"
alias cdev="cd /home/jonty/Documents/Study/Assignments/Y2/SysProg/"
alias vim="nvim"
alias cvmstart="virsh start cvm && virsh suspend cvm"
alias cvmstop="virsh resume cvm; virsh shutdown cvm"
alias sshtw="ssh jxr814@tinky-winky.cs.bham.ac.uk"
alias sn="clear && sncli && clear"

function open() {
    if [ ! -n "$1" ]; then
        echo "USAGE: xdg-open <filename>";
    else
        ( open "$1" > /dev/null 2>&1 & );
    fi
}

function cvmssh() {
        virsh start cvm --paused &> /dev/null
        virsh resume cvm; \
            ssh -t bham@localhost -p 22222 "clear; bash" && \
            virsh suspend cvm
}
