#!/bin/bash

function woff_files() {
  while read line; do
    # Get font files from url() in scss file
    FONT_FILES_FOR_TYPE="$(grep 'url(' "node_modules/@ibm/${line%\/[1-3acilnprty]*}/_$(basename "$line").scss")"
    FONT_FILES_WOFF="$(cut -d "'" -f 2 <<< "$FONT_FILES_FOR_TYPE")"

    # Link each woff and woff2 from scss file to source/fonts/
    while read FILE; do
      WOFF_FILE="$(cut -d '}' -f 2 <<< "$FILE")"
      echo "node_modules/@ibm/plex$WOFF_FILE"
    done <<< "$FONT_FILES_WOFF"

  done <<< "$1"
}

TARGET_PATH="$(pwd)/source/fonts/IBM-Plex-Sans/fonts/split/"
mkdir -p "${TARGET_PATH}woff2"
mkdir -p "${TARGET_PATH}woff"

SCSS_FILES="$(egrep '^@import' source/stylesheets/_ibm_plex_sans.sass | cut -f 2 -d "'")"
WOFF_FILES_SORTED="$(woff_files "${SCSS_FILES}")"

cd "${TARGET_PATH}woff"

while read FILE; do
  ln -s "../../../../../../${FILE}"
done <<< "$(grep '/woff/' <<< "${WOFF_FILES_SORTED}")"

cd "${TARGET_PATH}woff2"
while read FILE; do
  ln -s "../../../../../../${FILE}"
done <<< "$(grep '/woff2/' <<< "${WOFF_FILES_SORTED}")"
# get font scss file from own sass file
