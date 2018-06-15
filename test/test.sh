#!/bin/sh
set -e

DIR="$( cd "$(dirname "$0")" && pwd )"
mvn -f "$DIR"/junit4.pom.xml clean test
find "$DIR"/src -name \*.java -exec sed -E -i .old -f "$DIR/../junit4-to-5.sed" {} \;
mvn -f "$DIR"/junit5.pom.xml clean test

