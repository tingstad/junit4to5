#!/usr/bin/sed -E -f
# Richard H. Tingstad
# find . -name \*.java -exec sed -i.bak -E -f junit4-to-5.sed {} \; -exec rm {}.bak \;

s/org\.junit\.Test/org.junit.jupiter.api.Test/g

/^import org\.junit\.(Ignore|\*);/,$ {
    s/@Ignore([^A-Za-z0-9_$]|$)/@Disabled\1/g
}
s/org\.junit\.Ignore/org.junit.jupiter.api.Disabled/g

/^[[:space:]]*org\.junit\.Assert\.assert(True|False|ArrayEquals|(Not)?(Equals|Null|Same))/ {
    s/org\.junit\.Assert/org.junit.jupiter.api.Assertions/g
    b swap
}
/^import org\.junit\.(Assert|\*);/,$ {
    s/import org\.junit\.Assert/import org.junit.jupiter.api.Assertions/g
    s/import org\.junit\.\*/import org.junit.jupiter.api.\*/g
    s/^([[:space:]]*)Assert\.(fail)/\1Assertions.\2/g
    /^([[:space:]]*)Assert\.assert(True|False|ArrayEquals|(Not)?(Equals|Null|Same))/ {
        s/Assert\.assert/Assertions\.assert/g
        b swap
    }
}
/^import static org\.junit\.Assert\./,$ {
    /^import static org\.junit\.Assert\.\*/,$ {
        /^[[:space:]]*(assert(True|False|ArrayEquals|(Not)?(Equals|Null|Same))) *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertTrue/,$ {
        /^[[:space:]]*assertTrue *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertFalse/,$ {
        /^[[:space:]]*assertFalse *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertEquals/,$ {
        /^[[:space:]]*assertEquals *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertNotEquals/,$ {
        /^[[:space:]]*assertNotEquals *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertNull/,$ {
        /^[[:space:]]*assertNull *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertNotNull/,$ {
        /^[[:space:]]*assertNotNull *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertSame/,$ {
        /^[[:space:]]*assertSame *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertNotSame/,$ {
        /^[[:space:]]*assertNotSame *\(/ {
            b swap
        }
    }
    /^import static org\.junit\.Assert\.assertArrayEquals/,$ {
        /^[[:space:]]*assertArrayEquals *\(/ {
            b swap
        }
    }
}
s/org\.junit\.Assert/org.junit.jupiter.api.Assertions/g

s/org.\junit\.After;/org.junit.jupiter.api.AfterEach;/g

/^import org\.junit\.(Before|\*);/,$ {
    s/@Before([^A-Za-z0-9_$]|$)/@BeforeEach\1/g
}
s/org\.junit\.Before([^A-Za-z0-9_$]|$)/org.junit.jupiter.api.BeforeEach\1/g

s/org\.junit\.AfterClass/org.junit.jupiter.api.AfterAll/g
s/org\.junit\.BeforeClass/org.junit.jupiter.api.BeforeAll/g
s/@AfterClass/@AfterAll/g
s/@BeforeClass/@BeforeAll/g
s/@After([^A-Za-z]|$)/@AfterEach\1/g
s/org\.junit\.Assume/org.junit.jupiter.api.Assumptions/g

/^import org\.junit\.experimental\.categories\.(Category|\*);/,$ {
    #TODO multiple parms?
    s/@Category\((.*)\.class\)/@Tag("\1")/g
}
s/org\.junit\.experimental\.categories\.Category/org.junit.jupiter.api.Tag/g

/^import org\.junit\.runners\.Suite\.SuiteClasses;/,$ {
    s/^import org\.junit\.runners\.Suite\.SuiteClasses;/import org.junit.platform.suite.api.SelectClasses;/
    s/@(org\.junit\.runners\.Suite\.)?SuiteClasses\(/@SelectClasses(/g
}
/^import org\.junit\.runners\.Suite;/,$ {
    s/^import org\.junit\.runners\.Suite;/import org.junit.platform.suite.api.SelectClasses;/
    s/@(org\.junit\.runners\.)?Suite.SuiteClasses\(/@SelectClasses(/g
}
/^import org\.junit\.runners\.\*;/,$ {
    s/@(org\.junit\.runners\.)?Suite.SuiteClasses\(/@org.junit.platform.suite.api.SelectClasses(/g
}
/^import org\.junit\.ClassRule;/,$ {
    s|^[[:space:]]*@ClassRule|& // see org.junit.jupiter.api.extension.ExtendWith|
}
/^import org\.junit\.Rule;/,$ {
    s|^[[:space:]]*@Rule|& // see org.junit.jupiter.api.extension.ExtendWith|
}
s|^[[:space:]]*(@org\.junit\.)?(Class)?Rule|& // see org.junit.jupiter.api.extension.ExtendWith|

#TODO IncludeTags, imports. categories.* (Categories/Category) conflict (Tag/Excludetags)
/^import org\.junit\.experimental\.categories\.(Categories|\*);/,$ {
    #TODO multiple params
    s/@(org\.junit\.experimental\.categories\.)?Categories\.(Ex|In)cludeCategory\((.*)\.class\)/@org.junit.platform.suite.api.\2cludeTags("\3")/g
}
s/(org\.junit\.experimental\.categories\.)Categories\.(Ex|In)cludeCategory\((.*)\.class\)/org.junit.platform.suite.api.\2cludeTags("\3")/g

/import org\.junit\.runners\.Parameterized/d
/@RunWith\((org\.junit\.runners\.Parameterized\.)?Parameterized\.class\)/,${
    /^[[:space:]]*@RunWith\((org\.junit\.runners\.Parameterized\.)?Parameterized\.class\)[[:space:]]*$/d
    s/@RunWith\((org\.junit\.runners\.Parameterized\.)?Parameterized\.class\)//
    /@(Parameterized.)?Parameters/{
        s/.*//
        n
        s/[[:space:]]+[[:alpha:]][[:alnum:]]*[[:space:]]*\(/ parametersSource(/
    }
    /^[[:space:]]*public [A-Z][[:alnum:]]*[[:space:]]*\([^()]*\)/,${
        # Assumes that constructor precedes @Test methods
        /^[[:space:]]*public [A-Z][[:alnum:]]*[[:space:]]*\([^()]*\)/{
            h
            s/.*\((.*)\).*/\1/
            x
            s/(.*\().*(\).*)/\1\2/
        }
        /^[[:space:]]*@Test/{
            s/@Test/@org.junit.jupiter.params.ParameterizedTest/
            p
            s/@.*/@org.junit.jupiter.params.provider.MethodSource("parametersSource")/
            n
            G
            s/(.*\().*\n(.*)/\1\2) {/
        }
    }
}

:suite
/^import org\.junit\.experimental\.categories\.(Categories|\*);/,$ {
    /^import org\.junit\.runner\.(RunWith|\*);/,$ {
        /@RunWith\(Categories\.class\)/ b suiteSet
    }
}
/^import org\.junit\.runner\.(RunWith|\*);/,$ {
    /^import org\.junit\.experimental\.categories\.(Categories|\*);/,$ {
        /@RunWith\(Categories\.class\)/ b suiteSet
    }
}
/^import org\.junit\.experimental\.categories\.(Categories|\*);/,$ {
    /@org\.junit\.runner\.RunWith\(Categories\.class\)/ b suiteSet
}
/^import org\.junit\.runner\.(RunWith|\*);/,$ {
    /@RunWith\(org\.junit\.experimental\.categories\.Categories\.class\)/ b suiteSet
}
/@org\.junit\.runner\.RunWith\(org\.junit\.experimental\.categories\.Categories\.class\)/ b suiteSet
b suiteEnd
:suiteSet
    s|.*|@org.junit.platform.suite.api.Suite|
    b suite
:suiteEnd

/^import org\.junit\.experimental\.categories\./d

s/^import org\.junit\.\*;/import org.junit.jupiter.api.*;/

/^[[:space:]]*@(org\.junit\.)?Test[[:space:]]*\((.*[^[:alnum:]])?timeout[[:space:]]*=/ {
    h
    #remove // and /* */ comments:
    s,/(/.*|\*.*\*/),,g

    /timeout.*=/! {
        g; b endtimeout
    }
    /\/\*/ {
        g; b endtimeout
    }
    #only balanced parenthesis (max three levels):
    #^       ([       ({       (       )}*       )]*       )
    /^[^()]*\(([^()]*\(([^()]*\([^()]*\))*[^()]*\))*[^()]*\)[^()]*$/! {
        g; b endtimeout
    }
    /timeout.*=.*,.*expected.*=/ {
        #put expected first if not first:
        s/^([^(]*\()([^,]*), ?(.*expected.*)(\)[^)]*)$/\1\3, \2\4/
    }
    h
    #remove timeout from @Test:
    s/^([^,]*)(,.*)?timeout.*\)/\1)/
    #remove empty () if present:
    s/^([^(]*[^[:space:]])[[:space:]]*\([[:space:]]*\)[[:space:]]*$/\1/
    H; g
    #Test(timeout -> Timeout (line 1)
    s/@.*timeout[^=]*=[[:space:]]*/@org.junit.jupiter.api.Timeout(/
    s/(@org.junit.jupiter.api.Timeout\([0-9]+)_?000L?[[:space:]]*\)/\1)/
    /@org.junit.jupiter.api.Timeout\([0-9_]+\)/! {
        s/(@org.junit.jupiter.api.Timeout\()(.*)\)[^)]*(\n)/\1value=\2, unit=java.util.concurrent.TimeUnit.MILLISECONDS)\3/
    }
    h
    s/(.*)\n(.*)/\1/
    p
    g
    s/(.*)\n(.*)/\2/
    :endtimeout
}

# Assumes an indentation of 4 spaces
/^[[:space:]]*@Test.*expected/,/^    }/ {

    /^[[:space:]]*@Test.*expected/ {
        s/.*[= ](.*\.class).*/        \1/
        h
        s/.*/    @Test/
    }
    # method start:
    /^    [a-z].*\{ *$/ {
        p
        s/.*/        org.junit.jupiter.api.Assertions.assertThrows(/
        G
        a\
\        , () -> {
    }
    # method end:
    /^    }$/ {
        i\
\        });
    }

}

s/org\.junit\.runner\.RunWith/org.junit.jupiter.api.extension.ExtendWith/g
s/@RunWith/@ExtendWith/g

# org.springframework:spring-test:5.0.0
s/org.springframework.test.context.junit4.Spring(JUnit4Class)?Runner/org.springframework.test.context.junit.jupiter.SpringExtension/g
s/Spring(JUnit4Class)?Runner\.class/SpringExtension.class/g

# org.mockito:mockito-junit-jupiter:2.17.0
s/org\.mockito\.(runners|junit)\.MockitoJUnitRunner/org.mockito.junit.jupiter.MockitoExtension/g
s/MockitoJUnitRunner/MockitoExtension/g

# end
b

# swap parameters:
# assertTrue/False (<one>, <two>); => (<two>, <one>);
# assertEquals (<one>, <two>, <three>); => (<three>, <one>, <two>);
:swap
    h

    # replace all \\ with BB:
    :escs
        s/([^\\])\\\\/\1BB/g
    t escs

    s/\\"/BQ/g

    # strings and comments
    :strip
    /["\/]/{
        # string
        /^[^"\/]*"/{
            :str
            s/^([^"\/]*"S*)[^"S]/\1S/
            t str
            s/"(S*)"/S\1S/
            b strip
        }
        # comments
        /^[^"\/]*\//{
            # //
            /^[^\/]*\/\//{
                :slash
                s|(//L*)[^L]|\1L|
                t slash
                s|//(L*)|LL\1|
                b strip
            }
            # /* */
            /^[^\/]*\/\*/{
                /\/\*.*\*\//!{
                    :trailing
                    s|(/\*T*)[^T]|\1T|
                    t trailing
                    s|/\*(T*)|TT\1|
                    b strip
                }
                :star
                s|^([^/]*/\*K*)[^*K]|\1K|
                t star
                s|^([^/]*/\*K*)\*([^/])|\1K\2|
                t star
                s|/\*(K*)\*/|KK\1KK|
                b strip
            }
        }
    }

    # replace (...) with (yyy):
    :br
        s/(\(.*)\((y*)[^y()]/\1(\2y/g
    t br
        s/\((y*)\)/y\1y/g
    t br

    # replace []{...} with []zzz:
    :ar
        s/(\[\][[:space:]]*\{z*)[^z{}]([^}]*\})/\1z\2/g
    t ar
        s/\{(z*)\}/z\1z/g
    t ar

    #          (        ,        [,        ]  )        ;
    /^[^,();]*\([^,();]*,[^,();]*(,[^,();]*)*\)[^,();]*;[^,();]*$/{

        /assert(ArrayEquals|(Not)?(Equals|Same))/ {
            /(.*,.*,.*)/! {
                x
                b
            }
        }

        # x(AAA,AAA
        :aloop
        s/(.*\([A,]*)[^A,)]/\1A/
        t aloop
        # x(AAA,AAACCC
        :cloop
        s/(.*,AA*C*)[^AC,]/\1C/
        t cloop

        :loop
        /C$/{
            s/C$//
            x
            s/(.)\n(.*)/\
\1\2/
            /\n/!s/(.)$/\
\1/
            x
            b loop
        }
        x
        s/\n/\
\
/
        x
        :loopb
        /,$/ {
            s/,$//
            x
            s/,\n/\
\
/
            x
        }
        /A$/{
            s/A$//
            x
            s/(.)\n(.*)\n/\
\1\2\
/
            x
            b loopb
        }
    }
    g
    /assert(ArrayEquals|(Not)?(Equals|Same))/ s/\n *(.*)\n *(.*)\n *(.*)\n(.*)/\2, \3, \1\4/
    /assert(True|False|NotNull|Null)/ s/\n *(.*)\n *(.*)\n(.*)/\2, \1\3/

