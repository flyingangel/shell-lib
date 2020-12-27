#!/bin/bash
#helper to install config files

#Ask for user input with a question and a default value
#configurator.ask result question default_value
function configurator.ask() {
    local str answer

    str="$2"

    if [[ -n $3 ]]; then
        str+=" [$3]"
    fi

    input.read answer "$str: "

    #set default if empty
    answer=${answer:-$3}

    eval "$1=$answer"
}

#Ask for user if he should continue some operation
#if configurator.askcontinue question; then
function configurator.askcontinue() {
    local answer
    input.read answer "$1 (Y/n): "

    #to lowercase
    answer="${answer,,}"

    if [[ $answer == "y" || $answer == "yes" ]]; then
        return 0
    else
        return 1
    fi
}

#Display a section
#configurator.section string
function configurator.section() {
    echo -e "\n\e[1;33m[$1]\e[0m"
}
