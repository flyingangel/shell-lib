#!/bin/bash
#autoload file

function shelllib.autoload() {
	local DIR_ROOT
	
	DIR_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

	for file in "$DIR_ROOT"/lib/*; do
		source "$file"
	done
}

shelllib.autoload