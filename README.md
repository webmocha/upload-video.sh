# upload-video.sh

Shell script for uploading videos to s3 for sharing

## Requirements

- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- a valid account with permissions to a bucket
- `aws configure` to login

## Installation

- clone this project
- `sudo cp upload-video.sh /usr/local/bin/`

## Usage

_see usage example by running `upload-video.sh help`_

```
usage: ./upload-video.sh [directory] [video_file_name]

[directory]       the s3 prefix in s3://webmocha-public
[video_file_path] path for the video to upload

example:          ./upload-video.sh labs ~/Videos/42_preview.mp4

results:

  CREATE          s3://webmocha-public/labs/42_preview.mp4
  CREATE          s3://webmocha-public/labs/42_preview.html
  PUBLISHED       https://s3-us-west-2.amazonaws.com/webmocha-public/labs/42_preview.html
```
