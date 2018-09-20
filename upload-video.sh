#!/bin/bash

set -e

programname=$0
s3_bucket=webmocha-public
s3_region=us-west-2

usage() {
  cat <<HELP_USAGE
usage: ./upload-video.sh [directory] [video_file_name]

[directory]       the s3 prefix in s3://$s3_bucket
[video_file_path] path for the video to upload

example:          ./upload-video.sh labs ~/Videos/42_preview.mp4

results:

  CREATE          s3://$s3_bucket/labs/42_preview.mp4
  CREATE          s3://$s3_bucket/labs/42_preview.html
  PUBLISHED       https://s3-us-west-2.amazonaws.com/$s3_bucket/labs/42_preview.html
HELP_USAGE

  exit 1
}

[ -z "$1" ] || [ -z "$2" ] && { usage; }

s3_pre="$1"
s3_url="s3://$s3_bucket/$s3_pre"
s3_html_sc=REDUCED_REDUNDANCY
s3_video_sc=REDUCED_REDUNDANCY
video_filepath="$2"
video_filename="$(basename -- "$video_filepath")"
video_filename_no_ext=$(echo $video_filename | cut -f 1 -d '.')
html_template_url="https://raw.githubusercontent.com/webmocha/upload-video.sh/master/video-player-template.html"
video_player_html_filename="$video_filename_no_ext.html"
video_player_html_filepath="/tmp/$video_player_html_filename"

render_video_player_html() {
  curl $html_template_url | sed s/\{\{VIDEO_FILENAME\}\}/"$video_filename"/ > "$video_player_html_filepath"
}

upload_to_bucket() {
  aws s3 cp \
    --acl public-read \
    --storage-class $s3_video_sc \
    --sse AES256 \
    "$video_filepath" \
    $s3_url/$video_filename

  aws s3 cp \
    --acl public-read \
    --storage-class $s3_html_sc \
    --content-type text/html \
    --sse AES256 \
    "$video_player_html_filepath" \
    $s3_url/$video_player_html_filename
}

print_results() {
  echo ""
  echo ""
  echo "Video has been published"
  echo "Public Url:"
  echo "              https://s3-$s3_region.amazonaws.com/$s3_bucket/$s3_pre/$video_player_html_filename"
}

render_video_player_html

upload_to_bucket

print_results
