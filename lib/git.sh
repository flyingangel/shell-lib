#!/bin/bash

#show current git revision
function git_revision() {
    eval $1=$(git rev-parse --short HEAD)
}

#show current revision date
function git_revision_date() {
    eval $1=$(git log -1 --format=%cI)
}

#show current revision author email
function git_revision_email() {
    eval $1=$(git log -1 --format=%ce)
}

#display current git branch
function git_current_branch() {
    eval $1=$(git rev-parse --abbrev-ref HEAD || git describe --all)
}
