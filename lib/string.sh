#!/bin/bash

#Get base64
#string.base64encode result input
function string.base64encode() {
	eval "$1=$(echo "$2" | base64)"
}

#Get base64
#string.base64decode result input
function string.base64decode() {
	eval "$1=$(echo "$2" | base64 --decode)"
}

#Implode an array into a string with a choosen separator
#string.implode , "${FOO[@]}"
function string.implode() {
	local IFS="$1"
	shift
	echo "$*"
}

#Explode string into an array with a choosen separator
#string.explode , string
function string.explode() {
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
