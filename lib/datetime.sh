#!/bin/bash

#Get the current date and time
#date.datetime result
function date.datetime() {
    eval "$1=$(date '+%F_%T')"
}

#Get the current date
#date.date result
function date.date() {
    eval "$1=$(date '+%F')"
}

#Get the current time
#date.time result
function date.time() {
    eval "$1=$(date '+%T')"
}
