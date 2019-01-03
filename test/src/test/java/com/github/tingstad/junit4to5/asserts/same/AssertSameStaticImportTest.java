package com.github.tingstad.junit4to5.asserts.same;

import static org.junit.Assert.assertSame;

import org.junit.Test;

public class AssertSameStaticImportTest {

    @Test
    public void test() {
        Object object = "hello";
        assertSame("Spaces", object, object);
    }

}
