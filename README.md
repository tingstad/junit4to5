# JUnit 4 -> 5

A sed script to aid migration from JUnit 4 to JUnit 5.

1. Download [junit4-to-5.sed](https://github.com/tingstad/junit4to5/blob/master/junit4-to-5.sed):
```sh
$(command -v wget && printf %s -O- || command -v curl) \
    https://raw.githubusercontent.com/tingstad/junit4to5/master/junit4-to-5.sed \
    > junit4-to-5.sed
```

2. Run script on java test files:
```sh
find . -path '*/src/test/*.java' -exec sed -Ei.bak -f junit4-to-5.sed {} \; -exec rm {}.bak \;
```

3. Update your `pom.xml` dependencies, see [this example](https://github.com/tingstad/junit4to5/blob/master/test/junit5.pom.xml) or the [User Guide](https://junit.org/junit5/docs/current/user-guide/#running-tests-build).

Finally, fix any remaining build failures manually (or create an [issue](https://github.com/tingstad/junit4to5/issues) for me :))

The script replaces:

| Old                                         | New                                           |
|---------------------------------------------|-----------------------------------------------|
| `org.junit.Test`                            | `org.junit.jupiter.api.Test`                  |
| `org.junit.Assert`                          | `org.junit.jupiter.api.Assertions`            |
| `@Before`, `@After`                         | `@BeforeEach`, `@AfterEach`                   |
| `@BeforeClass`, `@AfterClass`               | `@BeforeAll`, `@AfterAll`                     |
| `@Ignore`                                   | `@Disabled`                                   |
| `@Category`                                 | `@Tag`                                        |
| `@RunWith`                                  | `@ExtendWith`                                 |
| `@Test(timeout=3000)`                       | `@Timeout(3)`                                 |
| `@Test(expected=Ex.class) m(){ ...`         | `@Test m(){ assertThrows(Ex.class, () -> ...` |
| `@RunWith(Parameterized.class)`, `@Test`    | `@ParameterizedTest`                          |
| `assertTrue/assertFalse("msg", val)`        | `assertTrue/assertFalse(val, "msg")`          |
| `assertNull/assertNotNull("msg", val)`      | `assertNull/assertNotNull(val, "msg")`        |
| `assertEquals(msg, expected, actual)`       | `assert(Not)Equals(expected, actual, msg)`    |
| `assertSame/NotSame(msg, expected, actual)` | `assert(Not)Same(expected, actual, msg)`      |
| `assertArrayEquals(msg, expected, actual)`  | `assertArrayEquals(expected, actual, msg)`    |

## Philosophy

1. Should only make changes with a high probability of being correct
2. Should not change unaffected lines and formatting
3. Should make changes non-breaking (compiling and passing) when possible
4. Should leave difficult problems to the humans and let the test fail to be easily detectable

## Why sed?

1. It is almost ubiquitous, so the script has few dependencies and is easy to install and run
2. Does not re-format code (see Philosophy)
3. Simple search and replace is easy to implement
4. Fun challenge to do a bit more complex tasks

## Limitations

1. Does not presume assertion library, leaving `assertThat` to fail
2. Does not parse arguments on multiple lines to shift the "message" parameter position of assertTrue/False/Equals
3. Probably many features still missing

