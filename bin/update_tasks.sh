#!/bin/bash
# vim: set sw=4 sts=4 et foldmethod=indent :

tasks_session='tasks:1'

function send_command(){
    window_name=$1
    cmd=$2
    tmux send-keys -t $window_name "clear; ${cmd}";
    tmux send-keys -t $window_name 'Enter'
}

function select_pane(){
    window_name=$1
    pane_index=$2
    tmux select-pane -t "${window_name}.${pane_index}"
}

send_command "$tasks_session" 'task -today'
select_pane "$tasks_session" 1
send_command "$tasks_session" 'task +today'
select_pane "$tasks_session" 2
send_command "$tasks_session" 'task +urgent'
select_pane "$tasks_session" 0

kanban_session='tasks:2'
send_command "$kanban_session" 'task +today'
select_pane "$kanban_session" 1
send_command "$kanban_session" 'task +code'
select_pane "$kanban_session" 2
send_command "$kanban_session" 'task +deploy'
select_pane "$kanban_session" 3
send_command "$kanban_session" 'task +documentation'
select_pane "$kanban_session" 0
