package com.github.tingstad.junit4to5;

import java.util.function.Supplier;
import org.junit.Test;

public class ExceptionTest {

    @Test(expected = NullPointerException.class)
    public void shouldFail() {
        Object o = null;
        o.hashCode();
    }

    @Test(expected = ArrayIndexOutOfBoundsException.class)
    public void arrayIndex() {
        int first = (new int[0])[1];
    }

    @Test(expected = NumberFormatException.class)
    public void testMultipleCurlies() {
        Supplier<String> s = () -> {
            return "nonum";
        };
        Integer.parseInt(s.get());
    }

}
