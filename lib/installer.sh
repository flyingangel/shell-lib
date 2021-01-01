#!/bin/bash
#Installer helper functions

#install binary to local binary directory
#install_binary real_path alias
function install_binary() {
    local binaryPath=$1
    local binaryName=$2

    #deduc name from script path without extension
    if [[ -z $2 ]]; then
        binaryName=$(basename "${binaryPath%.*}")
    fi

    local target="/usr/local/bin/$binaryName"

    #check if command exist
    if [[ -f $target ]]; then
        log.warning "Command $target already exist"
        return 1
    fi

    #if is window
    if is.windows; then
        cmd_input=$(printf 'mklink %s "%s"' "$target" "$binaryPath")
        echo "$cmd_input" | cmd
    else
        ln -s "$binaryPath" "$target"
        chmod ugo+x "$target"
    fi

    #check if symlink created
    if [[ ! -L $target ]]; then
        log.error "Problem creating symlink $target"
        return 1
    fi

    log.info "Command $target created"
}

#install man page for the binary
#install_manpage /path/to/man [customName]
function install_manpage() {
    local manFile=$1
    local manName=$2

    if [[ ! -f $manFile ]]; then
        log.error "Man file $manFile not exist"
        return 1
    fi

    manFile=$(realpath "$manFile")

    #extract basename if arg 2 not given
    if [[ -z $manName ]]; then
        manName=$(basename "$1")
    fi

    local target="/usr/local/man/man1/$manName"

    #check if man page already exist
    if [[ -L $target || -f $target ]]; then
        log.warning "Manpage $target already exist"
        return 1
    fi

    mkdir -p /usr/local/man/man1
    ln -s "$manFile" "$target"

    if [[ ! -L $target ]]; then
        log.error "Failed to create manpage $target"
        return 1
    fi

    log.info "Manpage $target created"
}

#Uninstall binary file
#uninstall_binary name
function uninstall_binary() {
    log.info "Remove /usr/local/bin/$1"
    rm -f "/usr/local/bin/$1" || return 1
}

#Uninstall man page
#uninstall_manpage name
function uninstall_manpage() {
    log.info "Remove /usr/local/man/man1/$1"
    rm -f "/usr/local/man/man1/$1" || return 1
}
