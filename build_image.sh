#!/usr/bin/bash

if [[ $1 == "full" ]]; then
    podman build -t teknikuglen/texlive-full:1 -f Containerfile-full .
else
    podman build -t teknikuglen/texlive-xetex:1 -f Containerfile-xetex .
fi
