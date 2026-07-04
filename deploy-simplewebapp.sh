#!/bin/bash
set -e

SRC="$1"
OUT=/var/www/simple-web-app-mvc-dotnet

if [ -z "$SRC" ] || [ ! -d "$SRC" ]; then
  echo "Usage: $0 <publish-dir>" >&2
  exit 1
fi

mkdir -p "$OUT"
rm -rf "${OUT:?}"/*
cp -rf "$SRC"/* "$OUT"/
service simplewebappmvcdotnet restart
