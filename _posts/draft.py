#!/bin/python

import sys
import datetime

DRAFT = """---
published: false
title: {title}
category: {category}
excerpt: TODO:Excerpt here!
feature_text: TODO:Feature text here!
feature_image: "https://picsum.photos/2560/600?image=733"
image: "https://picsum.photos/2560/600?image=733"
---

TODO:Content goes here
----
"""

def getArg(desc, argv):
    print(argv)
    if argv == []:
        value = raw_input(desc)
    else:
        value = argv.pop(0)
        print("Using arg: "+value)
    return value

def main():
    _path = sys.argv.pop(0)
    title = getArg("Title: ", sys.argv)
    category = getArg("Categories (comma separated): ", sys.argv)

    now = datetime.datetime.now()

    date = now.strftime("%Y-%m-%d")

    title_with_dashes = title.replace(" ", "-").lower()

    filename = "{date}-{title}.md".format(date=date, title=title_with_dashes)

    with open(filename, 'w') as draft:
        draft.write(DRAFT.format(title=title, category=category))

main()
