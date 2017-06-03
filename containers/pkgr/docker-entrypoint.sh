#!/bin/bash

if [ "$1" = 'pkgr' ]; then

  # wait for postgres process coming up on pkgr-postgresql
  until (echo > /dev/tcp/pkgr-postgres/5432) &> /dev/null; do
    echo "pkgr waiting for postgresql server to be ready..."
    sleep 5
  done

  cd "${PKGR_DIR}"

  # checkout repos
  if [ -d "${PKGR_DIR}/zammad" ]; then
    rm -r "${PKGR_DIR}/zammad"
  fi

  git clone --depth 1 "${ZAMMAD_URL}"

  if [ -d "${PKGR_DIR}/heroku-buildpack-ruby" ]; then
    rm -r "${PKGR_DIR}/heroku-buildpack-ruby"
  fi

  git clone --depth 1 "${BUILDPACK_URL}"

  # build packages
  pkgr package --buildpack=${PKGR_DIR}/heroku-buildpack-ruby ${PKGR_DIR}/zammad --env="DATABASE_URL=${DATABASE_URL}" "STACK=heroku-16"

fi
