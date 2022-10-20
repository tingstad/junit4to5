package com.github.tingstad.junit4to5.asserts;

import org.junit.Assert;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

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

    @Test
    public void inlineArray() {
        List<String> res = Arrays.asList("2-288-299", "4-488-499", "6-688-699");
        Assert.assertArrayEquals("msg", new String[] {"2-288-299", "4-488-499", "6-688-699"}, res.toArray());
    }
}
