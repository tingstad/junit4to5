package com.github.tingstad.junit4to5.category;

import org.junit.runners.Suite;

@org.junit.runner.RunWith(org.junit.experimental.categories.Categories.class)
@org.junit.experimental.categories.Categories.ExcludeCategory(SkipMe.class)
@Suite.SuiteClasses(ExcludeTest.class)
public class CategorySuiteQialified {
}
