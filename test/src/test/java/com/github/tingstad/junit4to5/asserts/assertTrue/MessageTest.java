package com.github.tingstad.junit4to5.asserts.assertTrue;

import org.junit.Test;

public class MessageTest {

    @Test
    public void assertTrueSimple() {
        org.junit.Assert.assertTrue("one", true);
        org.junit.Assert.assertTrue("two", 2 < 3 && "".matches("^$"));
        org.junit.Assert.assertTrue("three", "hello, world".equals("hello, world") );
    }

    @Test
    public void shouldNotBeAltered() {
        org.junit.Assert.assertTrue("foo".equals("foo"));
        org.junit.Assert.assertTrue("foo, bar".equals("foo, bar"));
        org.junit.Assert.assertTrue("foo\", bar".equals("foo\", bar"));
    }

}
