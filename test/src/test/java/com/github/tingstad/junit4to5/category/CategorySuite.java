package com.github.tingstad.junit4to5.category;

import org.junit.experimental.categories.Categories;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Categories.class)
@Categories.ExcludeCategory(SkipMe.class)
@Categories.IncludeCategory(FastTests.class)
@Suite.SuiteClasses(ExcludeTest.class)
public class CategorySuite {

}
