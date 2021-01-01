#!/bin/bash
#Display logs to the screen
#log.[type] "string"

function log.success() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "[$(date '+%T')] ${COLOR_GREEN}$input${COLOR_NONE}"
}

function log.warning() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "[$(date '+%T')] ${COLOR_MAGENTA}$input${COLOR_NONE}"
}

function log.error() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "[$(date '+%T')] ${COLOR_RED}$input${COLOR_NONE}"

    #exit if argument 2 given
    if [[ $2 == true ]]; then
        exit 1
    fi
}

function log.fatal() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "${COLOR_RED}$input${COLOR_NONE}"

    #exit if argument 2 given
    if [[ $2 == true ]]; then
        exit 1
    fi
}

function log.info() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "[$(date '+%T')] ${COLOR_GRAY}$input${COLOR_NONE}"
}

function log.newline() {
    echo
}

function log.header() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "${COLOR_YELLOW}$input${COLOR_NONE}"
}

function log.finish() {
    local input
    [[ ! -t 0 ]] && input=$(cat /dev/stdin) || input=$1
    echo -e "${COLOR_GREEN}$input${COLOR_NONE}"

    #exit if argument 2 given
    if [[ $2 == true ]]; then
        exit 0
    fi
}
