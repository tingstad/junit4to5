package com.github.tingstad.junit4to5.asserts;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertArrayEquals;

public class AssertArrayEqualsTest {

    @Test
    public void bytes() {
        char[] chars = "char array".toCharArray();
        String msg = "message";
        Assert.assertArrayEquals(msg, chars, chars);
        org.junit.Assert.assertArrayEquals(msg, chars, chars);
        assertArrayEquals(msg, chars, chars);
    }

}
