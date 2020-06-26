#!/bin/bash

#check if running as ROOT
function is_root() {
	if [ $(id -u) -ne 0 ]; then
		return 1
	fi
}
