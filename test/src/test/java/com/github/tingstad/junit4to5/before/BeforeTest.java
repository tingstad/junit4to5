package com.github.tingstad.junit4to5.before;

import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class BeforeTest {

    private static boolean beforeAll;

    private boolean before;

    @BeforeClass
    public static void setUpClass() {
        beforeAll = true;
    }

    @Before
    public void setUp() {
        before = true;
    }

    @Test
    public void test() {
        assertTrue(before);
        assertEquals(true, beforeAll);
    }

}
