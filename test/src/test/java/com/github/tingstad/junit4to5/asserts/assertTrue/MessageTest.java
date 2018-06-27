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
    public void multiLine1() {
        assertTrue("\"hello, world\" equals \"hello, world\"",
            "hello, world".equals("hello, world"));
    }

    @Test
    public void multiLine2() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\"",
            "hello, world".equals("hello, world"));
    }

    @Test
    public void multiLine3() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\"",
            "hello, world".equals("hello, world")
        );
    }

    @Test
    public void multiLine4() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\""
            ,
            "hello, world".equals("hello, world")
        );
    }

    @Test
    public void multiLine5() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\""
            , "hello, world".equals("hello, world")
        );
    }

    @Test
    public void multiLine6() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\""
            , "hello, world".equals("hello, world"));
    }

    @Test
    public void multiLine7() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\"", "hello, world".equals("hello, world"));
    }

    @Test
    public void multiLine8() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\"", "hello, world".equals("hello, world")
        );
    }

    @Test
    public void multiLine9() {
        assertTrue(
            "\"hello, world\" equals \"hello, world\"", "hello, world"
                .equals("hello, world")
        );
    }

    @Test
    public void multiLine10() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world"
            .equals("hello, world"));
    }

    @Test
    public void multiLine11() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world".equals(
            "hello, world"));
    }

    @Test
    public void function() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world".equals(
            new Supplier<String>() {

                @Override
                public String get() {
                    return "hello, world";
                }
            }.get())
        );
    }

    @Test
    public void lambda() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world".equals(
            ((Supplier<String>) () -> "hello, world").get())
        );
    }

    @Test
    public void lambda2() {
        assertTrue("\"hello, world\" equals \"hello, world\"", "hello, world".equals(
            ((Supplier<String>) () -> {
                return "hello, world";
            }).get()));
    }

}
