#!/bin/bash

#Check if running as ROOT
#if right.is_root; then
function right.is_root() {
	if [[ $(id -u) -ne 0 ]]; then
		return 1
	fi
}
