vpn() {
    default='dev'
    if [[ $2 == '' ]]; then
        2=$default
    fi
    if [[ $1 == 'connect' ]]; then
        nmcli connection up $2
        sudo systemctl restart systemd-resolved
    elif [[ $1 == 'disconnect' ]]; then
        nmcli connection down $2
    else
      nmcli connection "$@"
    fi
}

wifi() {
    nmcli device wifi "$@"
}

bluetooth() {
    default="74:9E:AF:E4:42:7B" # airpods
    if [[ ($1 == 'connect' || $1 == 'disconnect') && $2 == '' ]]; then
          echo "$1 $default\nquit" | bluetoothctl
    else
        echo "$@\nquit" | bluetoothctl
    fi
}
