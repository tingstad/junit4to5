package com.github.tingstad.junit4to5.category;

import org.junit.Test;
import org.junit.experimental.categories.Category;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import static org.junit.Assert.assertEquals;

@Category(FastTests.class)
public class CategoryTest {

    @Test
    public void test() throws Exception {
        Annotation[] annotations = getClass().getAnnotations();
        assertEquals(1, annotations.length);
        Annotation annotation = getClass().getAnnotations()[0];
        if (isUnit4()) {
            assertEquals("org.jun" + "it.experimental.categories.Category", annotation.annotationType().getName());
        } else {
            assertEquals("org.junit.jupiter.api.Tag", annotation.annotationType().getName());
        }
    }

    private boolean isUnit4() throws NoSuchMethodException {
        Method method = getClass().getMethod("test");
        Annotation annotation = method.getAnnotations()[0];
        return annotation.annotationType().getName().equals("org.jun" + "it.Test");
    }

}
