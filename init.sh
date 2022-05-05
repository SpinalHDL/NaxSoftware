#!/bin/sh

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1f-YFm6I185R9o_NniNBJkkVGNghRBEDK' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1f-YFm6I185R9o_NniNBJkkVGNghRBEDK" -O buildroot.zip && rm -rf /tmp/cookies.txt
unzip buildroot.zip

