#!/usr/bin/bash

fastfetch --pipe false --config /home/zijk/dotfiles/login/login-fetch.jsonc --logo arch_small \
| sed -re 's/\x1B]8;;file:\/\/\/[a-z]*\x1B\\(\/[a-z]*)\x1B\]8;;\x1B\\/\1/' \
    -e 's/([0-9]+:[0-9]+):[0-9]+$/\1 \(at boot\)/' \
    -e 's/ \(REV:1.0\)$//' -e 's/ \(12\) @ 4\.50 GHz$//' \
    -e 's/ [@\/][^\[]*\[(Discrete|Integrated)\]//' \
    -e 's/Memory\x1B[m: \x1B\[m[0-9]+\.[0-9]+ [MG]iB \/ ([0-9]+\.[0-9]+).*$/Memory\x1B[m: \1 GiB/' \
    -e 's/ - ext4$//' -e 's/\((R|TM)\)//g' -e 's/\\/\\\\/' > /etc/issue

echo >> /etc/issue
echo -e "\e[95mThis is one of the PCs ever\e[m" >> /etc/issue
echo >> /etc/issue
