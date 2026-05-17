#!/bin/bash

#Ask user to choose a server from /etc/hosts file and return the IP address
#host.ask result_ip
function host.ask() {
    local input ip list i host hostList textList dialogList

    i=1
    hostList=()
    textList=()
    dialogList=()
    list=$(printf '%s' "$(cat /etc/hosts)" | awk -F "\\\s+" '{print $1"\t"$2}')

    while read -r line; do
        #test for valid IP
        if [[ $line =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*$ ]]; then
            ip=$(printf '%s' "$line" | awk -F "\t" '{print $1}')
            host=$(printf '%s' "$line" | awk -F "\t" '{print $2}')

            if [[ $ip == 127.0.* ]]; then
                continue
            fi

            textList+=("$(printf '   %-2s\t%-15s\t%-30s' "$i" "$ip" "$host")")
            dialogList+=("$i" "$(printf '%-15s\t%s' "$ip" "$host")")
            hostList+=("$ip")

            ((i++))
        fi
    done < <(echo "$list")

    if command -v dialog >/dev/null; then
        input=$(dialog --keep-tite --menu "Choose a server:" 30 70 "${#dialogList[@]}" "${dialogList[@]}" 3>&1 1>&2 2>&3) || return 1
    else
        log.info "\"dialog\" command is missing - fallback CLI based selection"
        log.header "$(printf '   %-2s\t%-15s\t%-30s\n' '#' 'IP' 'Host')"

        # Fallback to text-based selection
        for line in "${textList[@]}"; do
            printf '%s\n' "$line"
        done

        log.newline

        read -rp 'Choose a server number: ' input
    fi

        #test if is a number
    if ! [[ "$input" =~ ^[0-9]+$ ]]; then
        log.error "Invalid number"
        return 1
    fi

    [[ $input -gt 0 ]] && ((input--))
    host="${hostList[$input]}"

    eval "$1=$host"
}
