#!/bin/bash

set -ueo pipefail

IMAGE_NAME="chirp-appdir-setup"

mkdir -p dist build
docker build -t $IMAGE_NAME .
docker run --rm -v "$PWD":/tmp/appdir $IMAGE_NAME

curl -L -o appimagetool.AppImage \
  https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage

chmod +x appimagetool.AppImage
ARCH=x86_64 ./appimagetool.AppImage build/ dist/Chirp-x86_64.AppImage
chmod +x dist/Chirp-x86_64.AppImage

NO_CLEANUP=false

if [[ "${1:-}" == "--no-cleanup" ]]; then
    NO_CLEANUP=true
fi

if [ "$NO_CLEANUP" = false ]; then
    rm -rf appimagetool.AppImage build
fi
