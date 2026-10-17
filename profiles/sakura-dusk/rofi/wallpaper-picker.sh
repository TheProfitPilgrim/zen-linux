#!/usr/bin/env bash

WALL_DIR="$HOME/projects/zen-linux/profiles/sakura-dusk/wallpapers"

SELECTED=$(
  find "$WALL_DIR" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.webp' \) \
    -printf '%f\n' |
  sort |
  while IFS= read -r filename; do
    printf '%s\0icon\x1f%s/%s\n' \
      "$filename" "$WALL_DIR" "$filename"
  done |
  rofi -no-config -dmenu -show-icons \
    -p "Sakura Dusk" \
    -theme-str '
      * {
        background: #1D1822;
        foreground: #EDE7EE;
      }

      window {
        width: 85%;
        background-color: #1D1822;
        border: 2px;
        border-color: #C88CA1;
        border-radius: 14px;
        padding: 10px;
      }

      mainbox {
        background-color: #1D1822;
        spacing: 12px;
      }

      inputbar {
        background-color: #26202D;
        padding: 14px;
        spacing: 10px;
      }

      prompt {
        background-color: #26202D;
        text-color: #E6B7C8;
      }

      entry {
        background-color: #26202D;
        text-color: #EDE7EE;
        placeholder: "Search wallpapers...";
      }

      listview {
        columns: 3;
        lines: 2;
        spacing: 10px;
        background-color: #1D1822;
        scrollbar: false;
      }

      element {
        orientation: vertical;
        padding: 10px;
        spacing: 8px;
        background-color: #1D1822;
        text-color: #EDE7EE;
      }

      element normal.normal {
        background-color: #1D1822;
        text-color: #EDE7EE;
      }

      element alternate.normal {
        background-color: #1D1822;
        text-color: #EDE7EE;
      }

      element selected.normal {
        background-color: #66527A;
        text-color: #F3E7DA;
      }

      element selected.active {
        background-color: #66527A;
        text-color: #F3E7DA;
      }

      element selected.urgent {
        background-color: #66527A;
        text-color: #F3E7DA;
      }

      element-icon {
        size: 260px;
        background-color: inherit;
      }

      element-text {
        horizontal-align: 0.5;
        background-color: inherit;
        text-color: inherit;
      }
    '
)

if [ -n "$SELECTED" ] && [ -f "$WALL_DIR/$SELECTED" ]; then
  feh --bg-fill "$WALL_DIR/$SELECTED"
fi
