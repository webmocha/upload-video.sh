#!/bin/bash

programname=$0

function usage {
  cat <<HELP_USAGE
usage: ./upload-video.sh [directory] [video_file_name]

[directory]       the s3 prefix in s3://webmocha-public
[video_file_name] the full name (not path)
                  including extension, to the video to upload

example:          ./upload-video.sh hpe-labs 148_cms-page.mp4

results:

  CREATE          s3://webmocha-public/hpe-labs/148_cms-page.mp4
  CREATE          s3://webmocha-public/hpe-labs/148_cms-page.html
  PUBLISHED       https://s3-us-west-2.amazonaws.com/webmocha-public/hpe-labs/148_cms-page.html
HELP_USAGE

  exit 1
}

[ -z $1 ] || [ -z $2 ] && { usage; }


