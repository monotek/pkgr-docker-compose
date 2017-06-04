#!/bin/bash

if [ "$1" = 'pkgr' ]; then

  # wait for postgres process coming up on pkgr-postgresql
  until (echo > /dev/tcp/pkgr-postgres/5432) &> /dev/null; do
    echo "pkgr waiting for postgresql server to be ready..."
    sleep 5
  done

  # checkout repos
  cd "${PKGR_DIR}"
  
  test -d "${PKGR_DIR}/zammad" && rm -r "${PKGR_DIR}/zammad"
  git clone --depth 1 "${ZAMMAD_URL}"

  test -d "${PKGR_DIR}/heroku-buildpack-ruby" && rm -r "${PKGR_DIR}/heroku-buildpack-ruby"
  git clone --depth 1 "${BUILDPACK_URL}"

  # get version
  VERSION="$(git -C ${PKGR_DIR}/zammad describe --tags --abbrev=0)"
  echo "build package for version ${VERSION}"
  sleep 2

  # build packages
  pkgr package --buildpack=${PKGR_DIR}/heroku-buildpack-ruby ${PKGR_DIR}/zammad --env="DATABASE_URL=${DATABASE_URL}" "STACK=heroku-16" --version=${VERSION:=0.0.0.}

fi
