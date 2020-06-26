#!/bin/bash

#get base64
#Usage base64encode return input
function base64encode() {
	eval $1=$(echo $2 | base64)
}

#get base64
#Usage base64decode return input
function base64decode() {
	eval $1=$(echo $2 | base64 --decode)
}

#display a readline with *
#Usage readLineWithStar return display_string
function readLineWithStar() {
	local input prompt char charcount

	unset input
	prompt=$2

	while IFS= read -p "$prompt" -r -s -n 1 char; do
		if [[ $char == $'\0' ]]; then
			break
		fi
		# Backspace
		if [[ $char == $'\177' ]]; then
			if [ $charcount -gt 0 ]; then
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

	eval $1=$input
}

#implode , "${FOO[@]}"
function implode() {
	local IFS="$1"
	shift
	echo "$*"
}

#explode , string
function explode() {
	local IFS="$1"

	#no delimiter or empty
	if [[ -z $1 ]]; then
		result=()
		for ((i = 0; i < ${#2}; ++i)); do
			result+=("${2:i:1}")
		done
	else
		read -r -a result <<<"$2"
	fi
}
