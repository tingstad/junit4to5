package com.github.tingstad.junit4to5.asserts;

import org.junit.Test;

import static org.junit.Assert.*;

public class StaticStarImportTest {

    @Test
    public void test() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
        assertNull(null);
        assertNull("msg", null);
        assertNotNull("not null");
        assertNotNull("can never be null", true);
        assertSame("same", Boolean.TRUE, Boolean.TRUE);
        assertNotSame("not same", Boolean.TRUE, Boolean.FALSE);
    }

}
