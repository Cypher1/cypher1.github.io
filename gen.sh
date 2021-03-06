#!/bin/bash

FILE="src/SUMMARY.md"

  function out {
  echo "$1" >> $FILE
}

echo "#Posts" > $FILE
out ""

out "- [About](about.md)"
for file in $(ls src/posts/*.md)
do
  title=$(grep "title:" $file | sed "s/^title: //")
  file=$(echo "$file" | sed "s/^src\///")
  out "- [$title]($file)"
done

out "- [Contact](contact.md)"
