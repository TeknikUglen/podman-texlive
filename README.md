# Texlive in a Container

This repository holds the means to build simple containers for LaTeX usage. Specifically I use `xelatex` for my projects.

There are two options. Either build a "full" texlive or a limited "xetex" container image.

Since the "full" image contains a complete texlive environment, the container can be used for other LaTeX based projects as well. On the other hand it's a rather large image. (5.08G)

The smaller "xetex" image is only about 1.5G in size.

The build command is based on podman, however it should work fine for docker as well. 

## Scripts

Scripts are supplied for building and test-starting the container. It is meant as a guide to implementing the container into a build system like Jenkins.

- build_image.sh - takes an optional parameter of "full" to build the full image, otherwise the xetex image is build. 
- start_container.sh - takes the same optional parameter (full) to run the full image in interactive mode. Otherwise the xetex image is used.
- resource/pdfcompile.sh - Is included inside the images and takes the tex file as the first argument and an optional second argument to name the output pdf file. 

## Build commands

```sh
podman build -t teknikuglen/texlive-full:1 -f Containerfile-full .
podman build -t teknikuglen/texlive-xetex:1 -f Containerfile-xetex .
```

## Compile pdf document

```sh
podman run --rm -v "$PWD/data:/data" localhost/teknikuglen/texlive-full:1 pdfcompile name.tex
podman run --rm -v "$PWD/data:/data" localhost/teknikuglen/texlive-xetex:1 pdfcompile name.tex
```

## Open command prompt inside container

```sh
podman run --rm -it -v "$PWD/data:/data" localhost/teknikuglen/texlive-full:1 bash
podman run --rm -it -v "$PWD/data:/data" localhost/teknikuglen/texlive-xetex:1 bash
```

## notes

Installing the `texlive-xetex` package in Debian 12 includes the following dependencies and is what the xetex image is based on.

- tex-common 
- tex-gyre 
- texlive-base
- texlive-binaries 
- texlive-fonts-recommended 
- texlive-latex-base 
- texlive-latex-extra 
- texlive-latex-recommended 
- texlive-pictures 
- texlive-plain-generic 
- texlive-xetex

[![License: ISC](https://img.shields.io/badge/License-ISC-blue.svg)](https://opensource.org/licenses/isc)