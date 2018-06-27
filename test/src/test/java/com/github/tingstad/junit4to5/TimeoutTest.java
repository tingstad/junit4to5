package com.github.tingstad.junit4to5;

import org.junit.Ignore;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

/**
 * @see ExceptionTest
 */
@Ignore("TODO junit5, assertTimeoutPreemptively")
public class TimeoutTest {

    @Test(timeout = 100)
    public void timeout() {
        assertTrue(true);
    }

    @Test(timeout = 100, expected = Exception.class)
    public void timeoutExpected() {
        throw new RuntimeException();
    }

    @Test(expected = Exception.class, timeout = 100)
    public void expectedTimeout() {
        throw new RuntimeException();
    }

}
