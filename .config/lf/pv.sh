#!/bin/sh
file=$1
w=$2
h=$3
x=$4
y=$5

image() {
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
	exit 1
}

case "$( file -Lb --mime-type "$file")" in
	image/*) image "$file";;
	video/*)
		CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$file")" | sha256sum | cut -d' ' -f1)"
		[ ! -f "$CACHE" ] && ffmpegthumbnailer -i "$file" -o "$CACHE" -s 0
		image "$CACHE"
		;;
	application/pdf)
			CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | cut -d' ' -f1)"
			[ ! -f "$CACHE.jpg" ] && pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
			image "$CACHE.jpg" "$2" "$3" "$4" "$5" "$1"
			;;
	*) pistol "$file";;
esac
