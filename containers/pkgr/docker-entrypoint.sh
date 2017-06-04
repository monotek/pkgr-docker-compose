#!/bin/bash

if [ "$1" = 'pkgr' ]; then

  # wait for postgres process coming up on pkgr-postgresql
  until (echo > /dev/tcp/pkgr-postgres/5432) &> /dev/null; do
    echo "pkgr waiting for postgresql server to be ready..."
    sleep 5
  done

  # checkout repos
  cd "${PKGR_DIR}"

  test -d "${PKGR_DIR}/${PACKAGE}" && rm -r "${PKGR_DIR}/${PACKAGE}"
  git clone -b "${PACKAGE_BRANCH}" "${ZAMMAD_URL}"

  test -d "${PKGR_DIR}/heroku-buildpack-ruby" && rm -r "${PKGR_DIR}/heroku-buildpack-ruby"
  git clone --depth 1 https://github.com/heroku/heroku-buildpack-ruby

  # get version
  GIT_TAG="$(git -C ${PKGR_DIR}/${PACKAGE} describe --tags --abbrev=0)"
  VERSION="${GIT_TAG:=0.0.0}"
  echo "Building ${PACKAGE} package with version ${VERSION}"
  sleep 2

  # build packages
  pkgr package --buildpack=${PKGR_DIR}/heroku-buildpack-ruby ${PKGR_DIR}/${PACKAGE} --env="DATABASE_URL=${DATABASE_URL}" "STACK=heroku-16" --version=${VERSION}

fi
