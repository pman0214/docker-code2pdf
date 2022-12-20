# pman0214/code2pdf

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> Code to PDF converter using vim + wkhtmltopdf

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

Convert source codes to PDF files with vim + wkhtmltopdf
- Use vim to syntax highlighting with the [shirotelin](https://github.com/yasukotelin/shirotelin) colorscheme.
- Use [Cica](https://github.com/miiton/Cica) font.

This docker image is inspired by [ソースコードをPDF化する（2022年版, Vimユーザ向け）](https://qiita.com/1007/items/2cdaae01e7cb4107fd4b) (Japanese page) and is based on [docker-wkhtmltopdf](https://github.com/Surnet/docker-wkhtmltopdf).

## Install

```bash
docker pull pman0214/code2pdf
```

## Simple Usage

Default `WORKDIR` is `/app`.
Note that `-t` option is **MANDATORY** to use vim.
Default operation is convert all the files in the current directory.

```bash
docker run -t --rm -v $PWD:/app pman0214/code2pdf
```

You can explicitly call code2pdf command.
```bash
docker run -t --rm -v $PWD:/app pman0214/code2pdf code2pdf *.java
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
