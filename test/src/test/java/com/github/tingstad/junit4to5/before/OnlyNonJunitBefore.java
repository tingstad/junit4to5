package com.github.tingstad.junit4to5.before;

import org.junit.Test;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Arrays;

import static org.junit.Assert.assertEquals;

public class OnlyNonJunitBefore {

    @Test
    @Before
    public void myBefore() throws NoSuchMethodException {
        Method method = getClass().getMethod("myBefore");
        Annotation[] annotations = method.getAnnotations();
        assertEquals("com.github.tingstad.junit4to5.before.Before",
                Arrays.stream(annotations)
                        .map(annotation -> annotation.annotationType().getName())
                        .sorted()
                        .findFirst()
                        .get());
    }

}
