#!/bin/bash
# Usage: ./convert_videos_inplace.sh [directory]
# Default is current directory

DIR="${1:-.}"

for f in "$DIR"/*.mp4; do
  [ -e "$f" ] || continue
  echo "Converting $f ..."
  ffmpeg -y -i "$f" -c:v libx264 -profile:v high -level 4.0 -pix_fmt yuv420p -c:a aac -movflags +faststart -preset fast -crf 23 "${f}.tmp.mp4"
  if [ $? -eq 0 ]; then
    mv "${f}.tmp.mp4" "$f"
    echo "Replaced $f with web-friendly version."
  else
    echo "Failed to convert $f"
    rm -f "${f}.tmp.mp4"
  fi
done
