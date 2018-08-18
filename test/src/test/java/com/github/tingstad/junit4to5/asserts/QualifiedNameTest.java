package com.github.tingstad.junit4to5.asserts;

import org.junit.Assert;
import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class QualifiedNameTest {

    @Test
    public void classImport() {
        Assert.assertTrue(true);
        Assert.assertTrue("message", true);
        Assert.assertFalse(false);
        Assert.assertFalse("message", false);
    }

    @Test
    public void staticImport() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
    }

}
