#!/bin/bash
set -e

ENV=Release
DOTNET=net7.0
TARGET=linux-x64

cd SimpleWebAppMVC

dotnet clean
dotnet build -c ${ENV} -r ${TARGET} --no-self-contained
dotnet publish -c ${ENV} -r ${TARGET} --no-self-contained

sudo /usr/local/bin/deploy-simplewebapp.sh "$(pwd)/bin/${ENV}/${DOTNET}/${TARGET}/publish"

cd ..
