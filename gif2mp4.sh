#!/usr/bin/env sh

if [ -z "$1" ]; then
    echo "Usage: $0 gif_file.gif"
    exit 127
fi

gif="$1"
mp4=$(echo "$gif" | perl -pe 's/.\w+$/.mp4/i')

if ! [ -f "$gif" ]; then
    echo "'$gif' is not a file"
    exit 1
fi


echo "Convert '$gif' to '$mp4'"
if ffmpeg -i ${gif} -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" ${mp4}
then
    echo "Converted '$gif' to '$mp4'"
else
    echo "Conversion failed for '$gif'"
    exit $?
fi
