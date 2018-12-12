package com.github.tingstad.junit4to5.asserts;

import org.junit.*;

import static org.junit.Assert.*;

public class ClassAndStaticStarImportTest {

    @Test
    public void classTest() {
        Assert.assertTrue(true);
        Assert.assertTrue("message", true);
        Assert.assertFalse(false);
        Assert.assertFalse("message", false);
    }

    @Test
    public void staticTest() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
        assertNull(null);
        assertNull("should be null", null);
        assertNotNull(1983);
        assertNotNull("1984, " + "is not null", 1984);
    }

}
