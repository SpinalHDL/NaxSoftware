#!/bin/sh
fileid="1f-YFm6I185R9o_NniNBJkkVGNghRBEDK"
filename="buildroot.zip"
html=`curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}"`
curl -Lb ./cookie "https://drive.google.com/uc?export=download&`echo ${html}|grep -Po '(confirm=[a-zA-Z0-9\-_]+)'`&id=${fileid}" -o ${filename}

unzip buildroot.zip

