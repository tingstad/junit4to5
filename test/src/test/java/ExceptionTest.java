import org.junit.Test;

public class ExceptionTest {

    @Test(expected = NullPointerException.class)
    public void shouldFail() {
        Object o = null;
        o.hashCode();
    }

}
