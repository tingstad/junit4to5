package com.github.tingstad.junit4to5;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.util.function.Supplier;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class MockitoTest {

    @Mock
    Supplier<String> supplier;

    @Test
    public void test() {
        when(supplier.get()).thenReturn("hello");

        assertEquals("hello", supplier.get());
    }

}
