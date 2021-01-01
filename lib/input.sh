#!/bin/bash

#Read user input
#input.read result display_string
function input.read() {
	local input

	read -rp "$2" input

	eval "$1=\$input"
}

#Display a readline with *
#input.read_secret result display_string
function input.read_secret() {
	local input prompt char charcount

	unset input
	prompt=$2

	while IFS= read -p "$prompt" -r -s -n 1 char; do
		if [[ $char == $'\0' ]]; then
			break
		fi
		# Backspace
		if [[ $char == $'\177' ]]; then
			if [[ $charcount -gt 0 ]]; then
				charcount=$((charcount - 1))
				prompt=$'\b \b'
				input="${input%?}"
			else
				prompt=''
			fi
		else
			charcount=$((charcount + 1))
			prompt='*'
			input+="$char"
		fi
	done

	#new line
	echo >/dev/tty

	eval "$1=\$input"
}

#Ask for user if he should continue some operation
#if input.askcontinue question; then
function input.askcontinue() {
    local answer
    input.read answer "$1 (Y/n): "

    #to lowercase
    answer="${answer,,}"

    if [[ $answer == 'y' || $answer == 'yes' ]]; then
        return 0
    else
        return 1
    fi
}
