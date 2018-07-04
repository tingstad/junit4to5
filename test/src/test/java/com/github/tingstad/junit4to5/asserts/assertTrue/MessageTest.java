package com.github.tingstad.junit4to5.asserts.assertTrue;

import org.junit.Test;

import java.util.function.Supplier;

import static org.junit.Assert.assertTrue;

/**
 * TODO: assertEquals
 * junit4 assertEquals([msg,]exp, act )
 * junit5 assertEquals( exp, act,[msg])
 */
public class MessageTest {

    @Test
    public void singleLine() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world".equals("hello, world"));
    }

    @Test
    public void singleLineWithMoreBackslashes() {
        assertTrue("\"hello, world\\\" equals \"hello, world\\\"", "hello, world\\".equals("hello, world\\"));
    }

}
