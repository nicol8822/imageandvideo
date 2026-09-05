#!/usr/bin/env bash
# scripts/optimize_video.sh
# Usage: ./scripts/optimize_video.sh "Characters_surfing_on_ladyfinger…_202609040458.mp4"
# Produces a high-quality web-friendly H.264 MP4 with faststart.

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <input.mp4> [output.mp4]"
  exit 1
fi

INPUT="$1"
OUTPUT="${2:-$(basename "$INPUT" .mp4)_optimized_1080p.mp4}"
BACKUP="original-$(basename "$INPUT")"

echo "Backing up original to: $BACKUP"
cp -n "$INPUT" "$BACKUP" || true

echo "Running ffmpeg to create optimized H.264 MP4: $OUTPUT"
ffmpeg -i "$BACKUP" \
  -c:v libx264 -preset slow -crf 20 -profile:v high -level 4.0 -pix_fmt yuv420p \
  -vf "scale='min(1920,iw)':'-2'" \
  -c:a aac -b:a 128k \
  -movflags +faststart \
  "$OUTPUT"

echo "Optimization complete: $OUTPUT"

# Optional: generate thumbnail and 10s preview
THUMB="$(basename "$INPUT" .mp4)_thumbnail.jpg"
PREVIEW="$(basename "$INPUT" .mp4)_preview_10s.mp4"

echo "Generating thumbnail ($THUMB) and 10s preview ($PREVIEW)"
ffmpeg -ss 00:00:02 -i "$BACKUP" -frames:v 1 -q:v 2 "$THUMB"
ffmpeg -ss 00:00:02 -i "$BACKUP" -t 10 -c:v libx264 -crf 24 -c:a aac -b:a 96k -movflags +faststart "$PREVIEW"

echo "Done. Keep $BACKUP untouched to preserve C2PA provenance boxes."
