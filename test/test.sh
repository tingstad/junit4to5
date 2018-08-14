#!/usr/bin/env bash
set -e

DIR="$( cd "$(dirname "$0")" && pwd )"

gnuver=$(sed --version 2>/dev/null | grep GNU | grep -E -o '[0-9]+\.[0-9]+' || true)
if [ -n "$gnuver" ] && [ ${gnuver%.*} -lt 4 -o ${gnuver%.*} -eq 4 -a ${gnuver#*.} -lt 2 ]; then
    args="-r"
else
    args="-E"
fi

diff "$DIR/expected.txt" <(sed $args -f "$DIR/../junit4-to-5.sed" "$DIR/test.txt")

mvn -f "$DIR/junit4.pom.xml" clean test
find "$DIR/src" -name \*.java -exec sed $args -i.bak -f "$DIR/../junit4-to-5.sed" {} \;
find "$DIR/src" -name \*.java.bak -delete
mvn -f "$DIR/junit5.pom.xml" clean test

