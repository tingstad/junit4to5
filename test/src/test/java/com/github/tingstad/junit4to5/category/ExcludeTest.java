package com.github.tingstad.junit4to5.category;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;


@Category(FastTests.class)
public class ExcludeTest {

    @Test
    @Category(SkipMe.class)
    public void doNotRun() {
        fail("Should not run");
    }

    @Test
    public void run() {
        assertTrue(true);
    }

}
