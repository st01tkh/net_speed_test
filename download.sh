#! /usr/bin/env bash
thisDir="$(cd "$(dirname "$0")" && pwd)"
defaultMirror="yandex"
downloadSelSize() {
  size="$1"
  mirror="$2"
  [ -n "$mirror" ] || mirror=$defaultMirror
  urlPath="$thisDir/url-${mirror}-${size}MiB.txt"
  logPath="$thisDir/wget-download-${mirror}-${size}MiB.log"
  if [ ! -e "$urlPath" ]; then
    echo "ERROR: no such file $urlPath"
    return 20
  fi
  time wget -i "$urlPath" -o "$logPath" -O /dev/null
}
case "$1" in 
  581) downloadSelSize "$1" ;;
  180) downloadSelSize "$1" ;;
  7) downloadSelSize "$1" ;;
  clear) find "$thisDir" -mindepth 1 -maxdepth 1 -type f -name 'wget-download-*-*.log' -delete ;;
  *)
    echo "Usage: $(basename "$0") <581|180|7|clear> [<yandex>]"
    echo "       Download 581, 180 or 7 Mib"
    echo "       from yandex or another mirror"
    exit 0
    ;;
esac
