#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

function select_pane(){
    window_name=$1
    pane_index=$2
    tmux select-pane -t "${window_name}.${pane_index}"
}

tmux -f tmux_tasks.conf new-session -d -s tasks
tmux split-window -h
tmux split-window -v
select_pane tasks:1 0

tmux -2 attach-session -t tasks
