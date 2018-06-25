#!/usr/bin/sed -E -f
#
# find . -name \*.java -exec sed -i.bak -E -f junit4-to-5.sed {} \;

s/org\.junit\.Test/org.junit.jupiter.api.Test/g

/import org.junit.(Assert|\*);/,$ {
    s/^( *)Assert.(assertTrue|assertFalse|fail|assertEquals)/\1Assertions.\2/g
}
s/org\.junit\.Assert/org.junit.jupiter.api.Assertions/g
s/org\.junit\.\*/org.junit.jupiter.api.\*/g

s/org.junit.After;/org.junit.jupiter.api.AfterEach;/g

/import org.junit.(Before|\*);/,$ {
    s/@Before([^A-Za-z0-9_$]|$)/@BeforeEach\1/g
}
s/(@?)org.junit.Before([^A-Za-z0-9_$]|$)/\1org.junit.jupiter.api.BeforeEach\2/g

s/org.junit.AfterClass/org.junit.jupiter.api.AfterAll/g
s/org.junit.BeforeClass/org.junit.jupiter.api.BeforeAll/g
s/@AfterClass/@AfterAll/g
s/@BeforeClass/@BeforeAll/g
s/@After([^A-Za-z]|$)/@AfterEach\1/g
s/org.junit.Ignore/org.junit.jupiter.api.Disabled/g
s/@Ignore/@Disabled/g
s/org.junit.Assume/org.junit.jupiter.api.Assumptions/g
s/org.junit.experimental.categories.Category/org.junit.jupiter.api.Tag/g
s/@Category\((.*)\.class\)/@Tag("\1")/g

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

s/org.junit.runner.RunWith/org.junit.jupiter.api.extension.ExtendWith/g
s/@RunWith/@ExtendWith/g

# org.springframework:spring-test:5.0.0
s/org.springframework.test.context.junit4.SpringRunner/org.springframework.test.context.junit.jupiter.SpringExtension/g
s/SpringRunner.class/SpringExtension.class/g

# org.mockito:mockito-junit-jupiter:2.16.3
s/org.mockito.(runners|junit).MockitoJUnitRunner/org.mockito.junit.jupiter.MockitoExtension/g
s/MockitoJUnitRunner/MockitoExtension/g

