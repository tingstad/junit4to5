package com.github.tingstad.junit4to5;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class ParameterizedTest {

    @Parameterized.Parameters(name= "{index}: double({0})={1}")
    public static Iterable<Object[]> data() {
        return Arrays.asList(new Object[][] { { 0, 0 }, { 1, 2 }, { 2, 4 },
                { 3, 6 }, { 4, 8 }, { 5, 10 }, { 6, 12 } });
    }

    private int input;
    private int expected;

    public ParameterizedTest(int input, int expected) {
        this.input = input;
        this.expected = expected;
    }

    @Test
    public void test() {
        assertEquals(expected, input * 2);
    }

}
