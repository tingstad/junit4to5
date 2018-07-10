#!/usr/bin/env bash
set -e

DIR="$( cd "$(dirname "$0")" && pwd )"

input="$(cat - <<- EOF
	org.junit.Assert.assertTrue(true);
	org.junit.Assert.assertTrue("msg", true);
	org.junit.Assert.assertTrue("msg", foo().and(bar(3)));
	org.junit.Assert.assertTrue("this" + "that )(", "hello, world".equals("hello, world"));
	org.junit.Assert.assertTrue("\"hello, world\".equals(\"hello, world\")", "hello, world".equals("hello, world"));
	org.junit.Assert.assertTrue("msg" + getSomething(), true);
	org.junit.Assert.assertTrue("msg", method(
	org.junit.Assert.assertTrue("esc\\"escesc\\\\\\"end", true);
	org.junit.Assert.assertTrue("msg" /*****/, true);
	EOF
)"
expected="$(cat - <<- EOF
	org.junit.jupiter.api.Assertions.assertTrue(true);
	org.junit.jupiter.api.Assertions.assertTrue( true,"msg");
	org.junit.jupiter.api.Assertions.assertTrue( foo().and(bar(3)),"msg");
	org.junit.jupiter.api.Assertions.assertTrue( "hello, world".equals("hello, world"),"this" + "that )(");
	org.junit.jupiter.api.Assertions.assertTrue( "hello, world".equals("hello, world"),"\"hello, world\".equals(\"hello, world\")");
	org.junit.jupiter.api.Assertions.assertTrue( true,"msg" + getSomething());
	org.junit.jupiter.api.Assertions.assertTrue("msg", method(
	org.junit.jupiter.api.Assertions.assertTrue( true,"esc\\"escesc\\\\\\"end");
	org.junit.jupiter.api.Assertions.assertTrue( true,"msg" /*****/);
	EOF
)"
diff <(echo "$expected") <(echo "$input" | sed --posix -E -f "$DIR/../junit4-to-5.sed")

#exit 0 #TODO remove
mvn -f "$DIR"/junit4.pom.xml clean test
find "$DIR"/src -name \*.java -exec sed -E -i.bak -f "$DIR/../junit4-to-5.sed" {} \;
mvn -f "$DIR"/junit5.pom.xml clean test

