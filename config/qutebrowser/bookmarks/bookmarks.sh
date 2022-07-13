#!/usr/bin/env bash

# convert Firefox bookmarks.html file to qutebrowser quickmarks


if [[ ! -e ~/.config/qutebrowser/bookmarks/bookmarks.html ]]; then
    echo "Error: No bookmarks.html"
    exit 2
fi

if [[ -e ~/.config/qutebrowser/quickmarks ]]; then
    rm ~/.config/qutebrowser/quickmarks
fi
    python /usr/share/qutebrowser/scripts/importer.py \
        ~/.config/qutebrowser/bookmarks/bookmarks.html >> ~/.config/qutebrowser/quickmarks

echo "Ok"
exit 0

