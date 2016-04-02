#! /usr/bin/env bash
thisDir="$(cd "$(dirname "$0")" && pwd)"
defaultMirror="yandex"
downloadSelSize() {
  size="$1"
  mirror="$2"
  [ -n "$mirror" ] || mirror=$defaultMirror
  urlPath="$thisDir/url-${mirror}-${size}.txt"
  logPath="$thisDir/wget-download-${mirror}-${size}.log"
  if [ ! -e "$urlPath" ]; then
    echo "ERROR: no such file $urlPath"
    return 20
  fi
  time wget -i "$urlPath" -o "$logPath" -O /dev/null
}
case "$1" in 
  581M|180M|7M|1M|57K) downloadSelSize "$1" ;;
  clear) find "$thisDir" -mindepth 1 -maxdepth 1 -type f -name 'wget-download-*-*.log' -delete ;;
  *)
    echo "Usage: $(basename "$0") <581M|180M|7M|1M|57K|clear> [<yandex>]"
    echo "       <581M|180M|7M|1M|57K|clear> - Download 581 Mib, 180 MiB, 7 MiB, 1 MiB, 57 KiB or clear logs"
    echo "       [<yandex>] - optional - Set mirror"
    exit 0
    ;;
esac
