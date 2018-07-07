#!/usr/bin/sed -E -f
#
# find . -name \*.java -exec sed -i.bak -E -f junit4-to-5.sed {} \;

s/org\.junit\.Test/org.junit.jupiter.api.Test/g

/^import org\.junit\.(Ignore|\*);/,$ {
    s/@Ignore([^A-Za-z0-9_$]|$)/@Disabled\1/g
}
s/org\.junit\.Ignore/org.junit.jupiter.api.Disabled/g

#TODO imports
/org\.junit\.Assert\.assertTrue\( *"[^"()\\]*",.*\);/ {
    # balanced parentheses, one level deep:
    # x      (x     [ (x      )x     ]* )x
    /^[^()]*\([^()]*(\([^()]*\)[^()]*)*\)[^()]*$/ {
        s/assertTrue\( *"([^"]*)", *(.*)\);/assertTrue(\2, "\1");/
    }
}

/^import org\.junit\.(Assert|\*);/,$ {
    s/^( *)Assert.(assertTrue|assertFalse|fail|assertEquals)/\1Assertions.\2/g
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

#TODO imports (SuiteClasses)
/^import org\.junit\.runners\.(Suite|\*);/,$ {
    s/@(org\.junit\.runners\.)?Suite.SuiteClasses\(/@org.junit.platform.suite.api.SelectClasses(/g
    /^import org\.junit\.runners\.Suite;/d
}
#TODO RunWith(Suite)?

#TODO IncludeTags, imports. categories.* (Categories/Category) conflict (Tag/Excludetags)
/^import org\.junit\.experimental\.categories\.(Categories|\*);/,$ {
    #TODO multiple params
    s/@(org\.junit\.experimental\.categories\.)?Categories.ExcludeCategory\((.*)\.class\)/@org.junit.platform.suite.api.ExcludeTags("\1")/g
}
s/org\.junit\.experimental\.categories\.Categories\.ExcludeCategory\((.*)\.class\)/org.junit.platform.suite.api.ExcludeTags("\1")/g

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
    s|.*|//@org.junit.platform.suite.api.Suite https://github.com/junit-team/junit5/issues/744|
    b suite
:suiteEnd

/^import org\.junit\.experimental\.categories\./d

s/^import org\.junit\.\*;/import org.junit.jupiter.api.*;/

# Assumes an indentation of 4 spaces
/@Test.*expected/,/    }/ {

    /@Test.*expected/ {
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
        , () -> {
    }
    # method end:
    /^    }$/ {
        i\
        });
    }

}

s/org\.junit\.runner\.RunWith/org.junit.jupiter.api.extension.ExtendWith/g
s/@RunWith/@ExtendWith/g

# org.springframework:spring-test:5.0.0
s/org.springframework.test.context.junit4.SpringRunner/org.springframework.test.context.junit.jupiter.SpringExtension/g
s/SpringRunner\.class/SpringExtension.class/g

# org.mockito:mockito-junit-jupiter:2.16.3
s/org\.mockito\.(runners|junit)\.MockitoJUnitRunner/org.mockito.junit.jupiter.MockitoExtension/g
s/MockitoJUnitRunner/MockitoExtension/g

