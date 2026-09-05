Characters_surfing_on_ladyfinger…_202609040458 - README

Description
-----------
This directory contains a large MP4 file: Characters_surfing_on_ladyfinger…_202609040458.mp4. The file contains C2PA provenance/signature boxes (embedded assertions) — do NOT overwrite or re-encode the original if you need to preserve those signatures.

What I added
------------
- .gitattributes — config to track MP4 files with Git LFS (recommended for large media files).
- scripts/optimize_video.sh — a ready-to-run shell script that:
  - copies the original to a backup (original-<name>.mp4),
  - produces a high-quality H.264 MP4 optimized for web streaming (faststart),
  - generates a thumbnail and a 10s preview clip.

How to run (locally)
--------------------
1) Install prerequisites on your machine:
   - ffmpeg (with libx264, libvpx, libopus if you need WebM)
   - git-lfs (if you plan to store MP4 in the repo)

2) Track MP4 with Git LFS (one-time setup):
   git lfs install
   # .gitattributes is already added in this branch; if you merge it, LFS will track *.mp4

3) Run the optimization script:
   chmod +x scripts/optimize_video.sh
   ./scripts/optimize_video.sh "Characters_surfing_on_ladyfinger…_202609040458.mp4"

Outputs created by the script:
- original-Characters_surfing_on_ladyfinger…_202609040458.mp4  # backup of original
- Characters_surfing_on_ladyfinger…_202609040458_optimized_1080p.mp4  # optimized H.264
- Characters_surfing_on_ladyfinger…_202609040458_thumbnail.jpg  # single-frame thumbnail
- Characters_surfing_on_ladyfinger…_202609040458_preview_10s.mp4 # 10s preview clip

Notes & cautions
----------------
- Re-encoding will likely remove or invalidate the C2PA assertions observed in the original file. Keep the backup copy if provenance must be preserved.
- Adjust CRF in the script: lower CRF &gt; higher quality &gt; larger file. CRF 18–20 is high quality; CRF 22–28 reduces filesize.
- If your source audio is already AAC and you want to avoid re-encoding audio, edit the ffmpeg command and replace "-c:a aac -b:a 128k" with "-c:a copy".

If you want, I can:
- Open a pull request adding these files into the repository (I already committed them on a branch),
- Or update the script to generate WebM/AV1 derivatives as well,
- Or provide a tuned ffmpeg command after you share ffprobe output (I inspected the file header already and saw H.264 + C2PA boxes).
