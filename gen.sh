#!/bin/bash

FILE="src/SUMMARY.md"

function out {
  echo "$1" >> $FILE
}

echo "#Posts" > $FILE
out ""

out "- [About](about.md)"

for node in src/posts/*
do
  if [ ! -d "$node" ]; then
    file="$node"
    if [[ ! $file =~ .*\.md ]]; then
      continue
    fi
    title=$(grep "title:" "$file" | sed "s/^title: //")
    file=$(echo "$file" | sed "s/^src\///")
    out "- [$title]($file)"
    continue
  fi
  dir="$node"
  if [ "$dir" = "src/posts/drafts" ]; then
    # Don't include drafts
    continue
  fi
  files=("$dir"/*.md)
  first_file="${files[0]}"
  if [ ! -f "$first_file" ]; then
    # No files, ignore this dir
    continue
  fi
  name=$(echo "$dir" | sed "s/^src\/posts\///")
  first_file=$(echo "$first_file" | sed "s/^src\///")

  out "- [$name]($first_file)"
  for file in "$dir"/*.md
  do
    title=$(grep "title:" "$file" | sed "s/^title: //")
    file=$(echo "$file" | sed "s/^src\///")
    out "  - [$title]($file)"
  done
done

out "- [Resume](resume.md)"
out "- [Contact](contact.md)"
