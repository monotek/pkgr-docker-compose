FROM ubuntu:16.04
MAINTAINER André Bauer <monotek23@gmail.com>

ARG BUILD_DATE

LABEL org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.license="AGPL-3.0" \
      org.label-schema.description="Docker container for PKGR build - Dummy Dockerfile for DockerHub autobuilds" \