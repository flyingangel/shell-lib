#!/bin/bash

#Show current git revision
#git.revision
function git.revision() {
    eval "$1=$(git rev-parse --short HEAD)"
}

#Show current 
#git.revision.date
function git.revision.date() {
    eval "$1=$(git log -1 --format=%cI)"
}

#Show current revision author email
#git.revision.email
function git.revision.email() {
    eval "$1=$(git log -1 --format=%ce)"
}

#Display current git branch
#git.branch
function git.branch() {
    eval "$1=$(git rev-parse --abbrev-ref HEAD || git describe --all)"
}
