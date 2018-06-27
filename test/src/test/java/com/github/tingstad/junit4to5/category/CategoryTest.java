package com.github.tingstad.junit4to5.category;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Arrays;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

@Category(FastTests.class)
public class CategoryTest {

    @Test
    @Category(SkipMe.class)
    public void doNotRun() {
        fail("Should not run");
    }

    @Test
    @Category(FastTests.class)
    public void testAnnotation() throws Exception {
        Method method = getClass().getMethod("testAnnotation");
        Annotation[] annotations = method.getAnnotations();
        assertEquals(2, annotations.length);
        Annotation annotation = Arrays.stream(annotations)
            .filter(a -> !a.annotationType().getName().endsWith("Test"))
            .findFirst().get();
        if (isUnit4(method)) {
            assertEquals("org.j" + "unit.experimental.categories.Category", annotation.annotationType().getName());
        } else {
            assertEquals("org.junit.jupiter.api.Tag", annotation.annotationType().getName());
        }
    }

    private boolean isUnit4(Method method) {
        Annotation annotation = method.getAnnotations()[0];
        return annotation.annotationType().getName().equals("org.j" + "unit.Test");
    }

}
