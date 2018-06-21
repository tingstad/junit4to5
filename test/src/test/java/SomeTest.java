import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

public class SomeTest {

    @Test
    public void test() {
        assertTrue(true);
        assertFalse(false);
        assertEquals(2, 2);
    }

    @Test
    @Ignore("Reason")
    public void ignored() {
        fail("Should not run");
    }

}
