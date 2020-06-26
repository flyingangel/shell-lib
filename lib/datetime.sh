#!/bin/bash

#Usage: get_current_date date [for_file]
function get_current_date {
    date=$(date '+%F_%T');

    if $2; then
        date=${date//:/\-}
    fi

    eval $1=$date
}