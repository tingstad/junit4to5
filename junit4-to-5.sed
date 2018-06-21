#!/usr/bin/sed -E -f
#
# find . -name \*.java -exec sed -i .old -E -f junit4-to-5.sed {} \;

s/org.junit.Test/org.junit.jupiter.api.Test/g
s/org.junit.Assert/org.junit.jupiter.api.Assertions/g
s/org.junit.After;/org.junit.jupiter.api.AfterEach;/g
s/org.junit.Before;/org.junit.jupiter.api.BeforeEach;/g
s/org.junit.AfterClass/org.junit.jupiter.api.AfterAll/g
s/org.junit.BeforeClass/org.junit.jupiter.api.BeforeAll/g
s/@AfterClass/@AfterAll/g
s/@BeforeClass/@BeforeAll/g
s/@After([^A-Za-z]|$)/@AfterEach\1/g
s/@Before([^A-Za-z]|$)/@BeforeEach\1/g
s/org.junit.Ignore/org.junit.jupiter.api.Disabled/g
s/@Ignore/@Disabled/g

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

