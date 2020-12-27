#!/bin/bash
#Display logs to the screen
#log.[type] "string"

function log.success() {
    echo -e "[$(date '+%T')] ${COLOR_GREEN}$1${COLOR_NONE}"
}

function log.warning() {
    echo -e "[$(date '+%T')] ${COLOR_MAGENTA}$1${COLOR_NONE}"
}

function log.error() {
    echo -e "[$(date '+%T')] ${COLOR_RED}$1${COLOR_NONE}"
}

function log.fatal() {
    echo -e "${COLOR_RED}$1${COLOR_NONE}"
}

function log.info() {
    echo -e "[$(date '+%T')] ${COLOR_GRAY}$1${COLOR_NONE}"
}

function log.newline() {
    echo
}

function log.header() {
    echo -e "${COLOR_YELLOW}$1${COLOR_NONE}"
}
