package com.github.tingstad.junit4to5.asserts;

import org.junit.*;

public class StarImportTest {

    @Test
    public void test() {
        Assert.assertTrue(true);
        Assert.assertTrue("message", true);
        Assert.assertFalse(false);
        Assert.assertFalse("message", false);
        Assert.assertNull(null);
        Assert.assertNull("message", null);
        Assert.assertNotNull("hello");
        Assert.assertNotNull("message", "hello");
        Assert.assertSame("same", Boolean.TRUE, Boolean.TRUE);
        Assert.assertNotSame("not same", Boolean.TRUE, Boolean.FALSE);
    }

}
