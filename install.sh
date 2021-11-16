#!/bin/sh
#
# safe and secure install script.

download() {
    url="https://raw.githubusercontent.com/sourtaste000/promptmore"
    url="${url}/master/promptmore.sh"

    curl "$url" > ~/promptmore.sh || {
        printf '%s\n' "error: Couldn't download promptless." >&2
        exit 1
    }
}

get_shell() {
    rc="${HOME}/.${SHELL##*/}rc"

    [ ! -f "$rc" ] &&
       rc="${HOME}/.profile"
}

main() {
    download
    get_shell

    printf '%s\n' ". ~/promptmore.sh" >> "$rc"
    printf '%s\n' "Installation complete. Relaunch your shell."
}

main "$@"
