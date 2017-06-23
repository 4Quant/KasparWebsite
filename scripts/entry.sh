#!/bin/bash
export LANG=C.UTF-8
export LANGUAGE=C.UTF-8
export LC_ALL=C.UTF-8
bundle
cd "/middleman/app" || exit 1
yarn install
npm rebuild node-sass
node_modules/gulp/bin/gulp.js
bundle exec middleman server
