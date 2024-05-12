#!/usr/bin/bash

if [[ $1 == "full" ]]; then
    podman run --rm -it -v "$PWD/data:/data" localhost/teknikuglen/texlive-full:1 bash
else
    podman run --rm -it -v "$PWD/data:/data" localhost/teknikuglen/texlive-xetex:1 bash
fi
