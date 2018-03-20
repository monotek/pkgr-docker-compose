FROM ruby:2.4.2
MAINTAINER André Bauer <monotek23@gmail.com>

ENV PKGR_DIR /data/pkgr
ENV ZAMMAD_URL https://github.com/monotek/zammad.git
ENV DATABASE_URL postgres://zammad:123456@pkgr-postgres/zammad_production
ENV PACKAGE zammad
ENV PACKAGE_BRANCH prometheus

VOLUME /data/pkgr

# adding backports
RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && apt-get update

# install openssl from backports
RUN apt-get install -y -t jessie-backports openssl libssl1.0.0 libssl-dev

# install dependencies
RUN apt-get update && apt-get install -y git-core libgmp3-dev

# install pkgr
RUN gem install pkgr

# docker init
COPY containers/pkgr/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pkgr"]
