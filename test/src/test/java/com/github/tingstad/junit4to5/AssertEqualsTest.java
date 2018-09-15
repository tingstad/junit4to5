package com.github.tingstad.junit4to5;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class AssertEqualsTest {

    @Test
    public void testString() {
        org.junit.Assert.assertEquals("message", "foo", "foo");
        Assert.assertEquals("message", "foo", "foo");
        assertEquals("message", "foo", "foo");
    }

    @Test
    public void testInt() {
        org.junit.Assert.assertEquals("message", 2, 1 + 1);
        Assert.assertEquals("message", 4, 2 * 2);
        assertEquals("message", -1, 0 - 1);
    }

}
