#!/bin/bash

if [ "$1" = 'pkgr' ]; then

  # wait for postgres process coming up on pkgr-postgresql
  until (echo > /dev/tcp/pkgr-postgres/5432) &> /dev/null; do
    echo "pkgr waiting for postgresql server to be ready..."
    sleep 5
  done

  cd ${PKGR_DIR}

  # checkout repos
  git clone --depth 1 "${ZAMMAD_URL}"
  git clone --depth 1 "${BUILDPACK_URL}"

  # build packages
  pkgr package --buildpack=${PKGR_DIR}/heroku-buildpack-ruby  ${PKGR_DIR}/zammad --env="DATABASE_URL=${DATABASE_URL}"

fi
