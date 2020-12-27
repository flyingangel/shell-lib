#!/bin/bash

#Init a timer
#timer.start
function timer.start() {
    timerStart=$(date +%s)

    export timerStart
}

#Stop timer and output the difference in second
#timer.end
function timer.end() {
    local timerEnd

    timerEnd=$(date +%s)

    echo $((timerEnd - timerStart))
}
