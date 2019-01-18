# builder image
FROM golang

LABEL description="gohugo build"
LABEL version="1.0"
LABEL maintainer="peter@froggle.org"

WORKDIR /tmp

RUN wget https://github.com/gohugoio/hugo/releases/download/v0.53/hugo_extended_0.53_Linux-64bit.tar.gz
RUN tar xz -C /usr/local/bin -f  hugo_extended_0.53_Linux-64bit.tar.gz

WORKDIR /root

COPY src/ /root/

RUN hugo



# final image
FROM nginx

LABEL description="dcrbounty server"
LABEL version="1.0"
LABEL maintainer="holdstockjamie@gmail.com"


COPY --from=0 /root/public/ /usr/share/nginx/html
