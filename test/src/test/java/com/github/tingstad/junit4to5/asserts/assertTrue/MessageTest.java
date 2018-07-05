package com.github.tingstad.junit4to5.asserts.assertTrue;

import org.junit.Test;

/**
 * Only cover simple cases, where we are sure we can separate the parameters correctly:
 * - One line (balanced parenthesis and semicolon at end)
 * - Simple string as first parameter; only ("[^"]*",
 */
public class MessageTest {

    @Test
    public void assertTrueSimple() {
        org.junit.Assert.assertTrue("one", true);
        org.junit.Assert.assertTrue("two", 2 < 3 && "".isEmpty());
        org.junit.Assert.assertTrue("three", "hello, world".equals("hello, world") );
    }

}
