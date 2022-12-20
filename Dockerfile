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

FROM surnet/alpine-wkhtmltopdf:3.15.0-0.12.6-small

COPY files/ /tmp/files/
RUN set -x && \
    apk update && \
    apk add --no-cache vim && \
    apk add --no-cache --virtual .fetch-deps curl && \
    mkdir /tmp/colorscheme && \
    curl -L https://github.com/yasukotelin/shirotelin/archive/refs/tags/v2.16.0.tar.gz | \
        tar zx -C /tmp/colorscheme --strip-components=1 && \
    mkdir /root/.vim && \
    cp -r /tmp/colorscheme/colors /root/.vim/ && \
    mkdir /tmp/fonts && \
    curl -L https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip -o /tmp/fonts/Cica.zip && \
    unzip /tmp/fonts/Cica.zip -d /tmp/fonts && \
    mkdir /root/.fonts && \
    cp /tmp/fonts/*.ttf /root/.fonts/ && \
    fc-cache -fv && \
    chmod 755 /tmp/files/code2pdf && \
    cp /tmp/files/code2pdf /bin/ && \
    cp /tmp/files/.vimrc /root/ && \
    apk del --purge .fetch-deps && \
    rm -rf /tmp/files /tmp/colorscheme /tmp/fonts && \
    rm -rf /var/cache/apk && \
    mkdir /var/cache/apk

WORKDIR /app
ENTRYPOINT []
CMD code2pdf *
