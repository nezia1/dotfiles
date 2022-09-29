set -gx DISPLAY (grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0
