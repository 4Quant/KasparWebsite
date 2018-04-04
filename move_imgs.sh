#!/bin/bash
while read webp; do
  echo "moveing" "$webp" "${webp//\.\/source/./build}"
  mv "$webp" "${webp//\.\/source/./build}"
done <<< "$(find ./source/images -iname '*.webp')"
exit 0
