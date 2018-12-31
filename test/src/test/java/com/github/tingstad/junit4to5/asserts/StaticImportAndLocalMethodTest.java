package com.github.tingstad.junit4to5.asserts;

import static org.junit.Assert.assertTrue;

import org.junit.Assert;
import org.junit.Test;

public class StaticImportAndLocalMethodTest {

    @Test
    public void staticTest() {
        assertFalse("Message first", false);
    }

    private void assertFalse(String message, boolean value) {
        Assert.assertTrue(message, !value);
    }

}
