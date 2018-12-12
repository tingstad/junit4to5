package com.github.tingstad.junit4to5.asserts;

import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class StaticMethodImport {

    @Test
    public void staticTest() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
        assertNull(null);
        assertNull("null is null", null);
        assertNotNull("hello");
        assertNotNull("hello is not null", "hello");
    }

}
