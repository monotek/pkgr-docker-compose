FROM ubuntu:16.04
MAINTAINER André Bauer <monotek23@gmail.com>

ENV PKGR_DIR /data/pkgr
ENV ZAMMAD_URL https://github.com/monotek/zammad.git
ENV DATABASE_URL postgres://zammad:123456@pkgr-postgres/zammad_production
ENV PACKAGE zammad
ENV PACKAGE_BRANCH develop

VOLUME /data/pkgr

# install dependencies
RUN apt-get update && apt-get install -y git-core ruby ruby-dev build-essential curl libmysqlclient-dev libpq-dev bison zlib1g-dev libssl-dev libxml2-dev libxml2-dev sqlite3 libsqlite3-dev autotools-dev libxslt1-dev libyaml-0-2 autoconf automake libreadline6-dev libyaml-dev libtool libgmp-dev libgdbm-dev libncurses5-dev pkg-config libffi-dev tzdata

# install pkgr
RUN gem install pkgr

# docker init
COPY containers/pkgr/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pkgr"]
