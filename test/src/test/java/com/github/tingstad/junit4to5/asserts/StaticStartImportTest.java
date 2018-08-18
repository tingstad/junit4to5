package com.github.tingstad.junit4to5.asserts;

import org.junit.Test;

import static org.junit.Assert.*;

public class StaticStartImportTest {

    @Test
    public void test() {
        assertTrue(true);
        assertTrue("message", true);
        assertFalse(false);
        assertFalse("message", false);
    }

}
