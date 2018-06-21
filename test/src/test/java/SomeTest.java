import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class SomeTest {

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
        assertFalse(false);
        assertEquals(true, beforeAll);
    }

    @Test
    @Ignore("Reason")
    public void ignored() {
        fail("Should not run");
    }

}
