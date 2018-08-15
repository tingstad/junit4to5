package com.github.tingstad.junit4to5;

import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.fail;
import static org.junit.Assume.assumeFalse;
import static org.junit.Assume.assumeTrue;

public class SomeTest {

    private static boolean beforeAll;

    @BeforeClass
    public static void setUpClass() {
        beforeAll = true;
    }

    @Test
    public void test() {
        assertFalse(false);
        assertEquals(true, beforeAll);
    }

    @Test
    @Ignore("Reason")
    public void ignored() {
        fail("Should not run");
    }

    @Test
    public void assumption() {
        assumeTrue(2 < 3);
        assumeFalse(3 < 2);
    }

}
