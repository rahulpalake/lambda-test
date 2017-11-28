#!/usr/bin/env bash

# Creates the deployable Lambda zip

set -e

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$script_dir/.."

rm -rf target
mkdir -p target

cp -r *.js package.json lib target/

cd target
npm install --production
zip -r greeting-lambda.zip .
cd "$script_dir/.."