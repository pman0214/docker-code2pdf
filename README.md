# pman0214/code2pdf

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> Code to PDF converter using highlight + wkhtmltopdf

## Table of Contents
- [pman0214/code2pdf](#pman0214code2pdf)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Install](#install)
  - [Simple Usage](#simple-usage)
  - [Building](#building)
  - [Contribute](#contribute)
  - [Copyright, License](#copyright-license)

## Overview

Convert source codes to PDF files with highlight + wkhtmltopdf
- Use [Cica](https://github.com/miiton/Cica) font.

This docker image is based on [docker-wkhtmltopdf](https://github.com/Surnet/docker-wkhtmltopdf).

## Install

```bash
docker pull pman0214/code2pdf
```

## Simple Usage

Default `WORKDIR` is `/app`.

```bash
docker run --rm -v $PWD:/app pman0214/code2pdf code2pdf *.java
```

You cannot omit `code2pdf` command after docker image name; you can run any command inside the docker container.

```bash
docker run --rm -v $PWD:/app pman0214/code2pdf sh -c 'cd /app; for i in $(ls); do cd /app/$i; code2pdf *.java; done'
```

You can specify output directory with the `-o` option. But remember, path have to be inside a docker container.
```bash
mkdir out
docker run -t --rm -v $PWD:/app -w /app/src pman0214/code2pdf code2pdf -o ../out/ *.java
```

## Building

If you want to build this image by yourself, please prepare for a multi-architecture builder referring to the [official documents](https://docs.docker.com/desktop/multi-arch/).
```bash
docker run --privileged --rm tonistiigi/binfmt --uninstall "qemu-*"
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --name multiarch --driver docker-container
docker buildx use multiarch
docker buildx inspect --bootstrap
```
In this example, `multiarch` is the name of the multi-architecture builder.

You can build this image with your own multi-architecture builder.
```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t "code2pdf" \
  . --load
```
`--push` option instead of `--load` with appropriate tag pushes built images to GitHub.

## Contribute

* Bugfix pull requests are welcome.

## Copyright, License

All the source files are released under the MIT license.
See `LICENSE`.

Copyright (c) 2022, Shigemi ISHIDA

[shirotelin](https://github.com/yasukotelin/shirotelin) colorscheme is released under the MIT license.

Copyright (c) 2019 yasukotelin

[Cica](https://github.com/miiton/Cica) font is released under the SIL Open Font License 1.1.

Copyright (c) 2018, Takahiro Minami (https://tmnm.tech), with Reserved Font Name Cica.
