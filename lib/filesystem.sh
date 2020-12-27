#!/bin/bash

#Get file size as byte
#file.size result filename
function file.size() {
    if [[ -f $2 ]]; then
        eval "$1=$(stat --printf="%s" "$2")"
    else
        eval "$1=0"
    fi
}

#Get file size as human readable string (X Mb, Y Kb)
#file.size.readable result filename
function file.size.readable() {
    local fs
    file.size fs "$2"

    #if less than 1 Mb, convert to Kb
    if [ "$fs" -lt 1024 ]; then
        fs="$fs b"
    elif [ "$fs" -lt 1048576 ]; then
        fs="$((fs / 1024))' 'Kb"
    else
        fs="$((fs / 1024 / 1024))' 'Mb"
    fi

    eval "$1=$fs"
}

#Get free space of a drive
#disk.free_space result /path/to/dir
function disk.free_space() {
    eval "$1=$(df -P "$2" | tail -1 | awk '{print $4}')"
}

#Get the directory of the called (not sourced) script represent by $0
#script.dir result
function script.dir() {
    eval "$1=$(cd -- "$(dirname -- "$0")" && pwd -P)"
}

#Get the directory of the real physical location of the called (not sourced) script represent by $0
#script.dir.real result
function script.dir.real() {
    eval "$1=$(dirname -- "$(realpath "$0")")"
}

#Get the directory where this command is declared.
#This function is meant to be copy pasted and should not be called
function dir.this() {
    eval "$1=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
}

#Check if script is called directly (as opposed to from another script)
#if is.direct_call; then
function is.direct_call() {
    local user

    user=$(id -u -n)

    #if apache then is not a direct call
    if [[ $user == "www-data" || $user == "apache" ]]; then
        return 1
        #run using sudo
    elif [[ $PARENT_COMMAND == "sudo" ]]; then
        [[ $SHLVL -ge 2 ]] && return 1 || return 0
        #real user is root
    else
        [[ $SHLVL -gt 2 ]] && return 1 || return 0
    fi
}

#Check if we use windows bash
#if is.windows; then
function is.windows() {
    [[ -n "$WINDIR" ]]
}

#Check if we use linux
#if is.linux; then
function is.linux() {
    #shellcheck disable=SC2003
    [[ $(uname -s) == Linux* ]]
}
