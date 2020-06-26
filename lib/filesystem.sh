#!/bin/bash

#get file size as byte
#Usage file_size $1 $2
function file_size() {
    if [ ! -f $2 ]; then
        eval $1=0
    else
        eval $1=$(stat --printf="%s" $2)
    fi
}

#get file size as human readable string (X Mb, Y Kb)
function file_size_readable() {
    local fs
    file_size fs $2

    #if less than 1 Mb, convert to Kb
    if [ "$fs" -lt 1048576 ]; then
        fs="$(($fs / 1024))' 'Kb"
    else
        fs="$(($fs / 1024 / 1024))' 'Mb"
    fi

    eval $1=$fs
}

#get free space of a drive
#Usage get_free_space space /path/to/dir
function get_free_space() {
    eval $1=$(df -P $2 | tail -1 | awk '{print $4}')
}

#get the directory of the called (not sourced) script represent by $0
#Usage get_current_dir currentDir
function get_script_dir() {
    eval $1=$(cd -- "$(dirname -- "$0")" && pwd -P)
}

#get the directory of the real physical location of the called (not sourced) script represent by $0
#Usage get_current_dir currentDir
function get_script_real_dir() {
    eval $1=$(dirname -- $(realpath $0))
}

#get the directory where this command is declared
function get_this_dir() {
    eval $1=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
}

#check if script is called directly (as opposed to from another script)
function is_direct_call() {
    local apache=true
    isApache || apache=false

    #if apache then is not a direct call
    if $apache; then
        return 1
        #run using sudo
    elif [ $PARENT_COMMAND = "sudo" ]; then
        [[ $SHLVL -ge 2 ]] && return 1 || return 0
        #real user is root
    else
        [[ $SHLVL -gt 2 ]] && return 1 || return 0
    fi
}

#check if we use windows bash
function is_windows() {
    [[ -n "$WINDIR" ]]
}

function is_linux() {
    [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]
}
