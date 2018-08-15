package com.github.tingstad.junit4to5;

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

}
