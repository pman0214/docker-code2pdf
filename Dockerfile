# Copyright (c) 2022, Shigemi ISHIDA
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM debian:10-slim

ARG WKHTMLTOX_VER=0.12.6-1

ENV PATH=/usr/local/bin:$PATH

COPY files/ /tmp/files/

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends highlight fontconfig ca-certificates && \
    apt-get install -y --no-install-recommends curl unzip && \
    mkdir /tmp/fonts && \
    curl -L https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip -o /tmp/fonts/Cica.zip && \
    unzip /tmp/fonts/Cica.zip -d /tmp/fonts && \
    mkdir /root/.fonts && \
    cp /tmp/fonts/*.ttf /root/.fonts/ && \
    fc-cache -fv && \
    chmod 755 /tmp/files/code2pdf && \
    cp /tmp/files/code2pdf /bin/ && \
    mkdir /tmp/wkhtmltopdf && \
    case $(arch) in \
        aarch64) architecture=arm64 ;; \
        x86_64) architecture=amd64 ;; \
        *) architecture=$(arch) ;; \
    esac && \
    curl -L https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTMLTOX_VER}/wkhtmltox_${WKHTMLTOX_VER}.buster_${architecture}.deb -o /tmp/wkhtmltopdf/wkhtmltox.deb && \
    apt-get install -y --no-install-recommends libbsd0 libfontenc1 libjpeg62-turbo libx11-6 libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxrender1 lsb-base x11-common xfonts-75dpi xfonts-base xfonts-encodings xfonts-utils && \
    dpkg -i /tmp/wkhtmltopdf/wkhtmltox.deb && \
    rm -rf /tmp/files /tmp/fonts /tmp/wkhtmltopdf && \
    apt-get remove -y --purge curl unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
CMD ["sh"]
