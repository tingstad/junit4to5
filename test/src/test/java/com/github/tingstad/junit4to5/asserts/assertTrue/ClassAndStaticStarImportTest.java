package com.github.tingstad.junit4to5.asserts.assertTrue;

import org.junit.*;

import static org.junit.Assert.*;

public class ClassAndStaticStarImportTest {

    @Test
    public void classTest() {
        Assert.assertTrue(true);
    }

    @Test
    public void staticTest() {
        assertTrue(true);
    }

}
