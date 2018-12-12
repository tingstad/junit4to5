package com.github.tingstad.junit4to5.asserts;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class QualifiedNameTest {

    @Test
    public void staticImport() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
        assertNull(null);
        assertNull("surely null", null);
        assertNotNull("not null");
        assertNotNull("should not be null", "not null");
    }
    @Test
    public void classImport() {
        Assert.assertTrue(true);
        Assert.assertTrue("message", true);
        Assert.assertFalse(false);
        Assert.assertFalse("message", false);
        Assert.assertNull(null);
        Assert.assertNull("surely null", null);
        Assert.assertNotNull("not null");
        Assert.assertNotNull("should not be null", "not null");
    }

}
