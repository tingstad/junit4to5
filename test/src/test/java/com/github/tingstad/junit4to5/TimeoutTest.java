package com.github.tingstad.junit4to5;

import org.junit.Test;

import static org.junit.Assert.assertTrue;

/**
 * @see ExceptionTest
 */
public class TimeoutTest {

    private final int val = 100;

    @Test  (timeout = 1000)
    public void timeout() {
        assertTrue(true);
    }

    @Test (timeout = val)
    public void timeoutVal() {
        assertTrue(true);
    }

    @Test(timeout = 2_000L, expected = Exception.class)
    public void timeoutExpected() {
        throw new RuntimeException();
    }

    @Test(expected = Exception.class, timeout = 100 * (2 + 3))
    public void expectedTimeout() {
        throw new RuntimeException();
    }

}
