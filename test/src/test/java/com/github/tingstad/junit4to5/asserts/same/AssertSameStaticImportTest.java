package com.github.tingstad.junit4to5.asserts.same;

import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertNotSame;

import org.junit.Test;

public class AssertSameStaticImportTest {

    @Test
    public void test() {
        Object object = "hello";
        assertSame("Spaces", object, object);
		assertSame("Tab indentation", object, object);
    }

    @Test
    public void testAssertNotSame() {
        assertNotSame("not same", "one", "two");
    }

}
