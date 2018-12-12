# JUnit 4 -> 5

A sed script to aid migration from JUnit 4 to 5.

```
find ./src/ -name \*.java -exec sed -E -i.bak -f junit4-to-5.sed {} \;
```
replaces:

Old                                   | New
--------------------------------------|-----------------------------------------------
`org.junit.Test`                      | `org.junit.jupiter.api.Test`
`org.junit.Assert`                    | `org.junit.jupiter.api.Assertions`
`@Before`, `@After`                   | `@BeforeEach`, `@AfterEach`
`@BeforeClass`, `@AfterClass`         | `@BeforeAll`, `@AfterAll`
`@Ignore`                             | `@Disabled`
`@Category`                           | `@Tag`
`@RunWith`                            | `@ExtendWith`
`@Test(expected=Ex.class) m(){ ...`   | `@Test m(){ assertThrows(Ex.class, () -> ...`
`assertTrue/False/Null("msg", a)`     | `assertTrue/False/Null(a, "msg")`
`assertEquals(msg, expected, actual)` | `assertEquals(expected, actual, msg)`

## Motivation

Save a ton of work by employing a re-usable script instead of repeating manual chores.

## How to use

Download file [junit4-to-5.sed](https://github.com/tingstad/junit4to5/blob/master/junit4-to-5.sed) ([raw](https://raw.githubusercontent.com/tingstad/junit4to5/master/junit4-to-5.sed)) and run:
```
find ./src/ -name \*.java -exec sed -E -i.bak -f junit4-to-5.sed {} \;
```
Then update your `pom.xml` dependencies, see [this example](https://github.com/tingstad/junit4to5/blob/master/test/junit5.pom.xml) or the [User Guide](https://junit.org/junit5/docs/current/user-guide/#running-tests-build).
Finally, fix any remaining build failures manually (or create an [issue](https://github.com/tingstad/junit4to5/issues) for me :))

## Philosophy

1. Tries not to frak up by being conservative and only making changes with a high probability of being correct
2. Should not change unaffected lines and formatting
3. Should make changes non-breaking (compiling and passing) when possible
4. Should leave difficult problems to the humans and let the test fail to be easily detectable

## Why sed?

1. It is almost ubiquitous, so the script has few dependencies and is easy to install and run
2. Simple search and replace is easy to implement
3. Fun challenge to do a bit more complex tasks

## Limitations

1. Does not presume assertion library, leaving `assertThat` to fail
2. Does not parse arguments on multiple lines to shift the "message" parameter position of assertTrue/False/Equals
3. `@Suite` [not yet supported in JUnit 5](https://github.com/junit-team/junit5/issues/744)
4. Probably many features still missing

