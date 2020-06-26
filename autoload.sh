#!/bin/bash
#autoload functions

dirRoot=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

for file in $dirRoot/lib/*; do
	source $file
done
