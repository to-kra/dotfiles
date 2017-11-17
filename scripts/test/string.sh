#!/usr/bin/env bats
# -*- tab-width: 2; encoding: utf-8 -*-

load ../shellTools
load ./testUtils

# stringToLowerCase()
# --------------------------------------------------------------#

@test "stringToLowerCase() with 'This Is A Test String' should return 'this is a test string'" {
  run stringToLowerCase "This Is A Test String"
  assertSuccess $status
  assertEquals "$output" "this is a test string"
}

@test "stringToLowerCase() with an empty string should return empty string ''" {
  run stringToLowerCase ""
  assertSuccess $status
  assertEquals "$output" ""
}

@test "stringToLowerCase() with a whitespace string ' ' should return same string ' '" {
  run stringToLowerCase " "
  assertSuccess $status
  assertEquals "$output" " "
}

@test "stringToLowerCase() with 'TestString' should return 'teststring'" {
  run stringToLowerCase "TestString"
  assertSuccess $status
  assertEquals "$output" "teststring"
}

@test "stringToLowerCase() with 'TESTSTRING' should return 'teststring'" {
  run stringToLowerCase "TESTSTRING"
  assertSuccess $status
  assertEquals "$output" "teststring"
}

@test "stringToLowerCase() with 'teststring' should return 'teststring'" {
  run stringToLowerCase "teststring"
  assertSuccess $status
  assertEquals "$output" "teststring"
}

@test "stringToLowerCase() with 'Test String' should return 'test string'" {
  run stringToLowerCase "Test String"
  assertSuccess $status
  assertEquals "$output" "test string"
}

@test "stringToLowerCase() with '<a>Test&amp;String</a>' should return 'test string'" {
  run stringToLowerCase "<a>Test&amp;String</a>"
  assertSuccess $status
  assertEquals "$output" "<a>test&amp;string</a>"
}

@test "stringToLowerCase() with '@TestString!' should return '@teststring!'" {
  run stringToLowerCase '@TestString!'
  assertSuccess $status
  assertEquals "$output" "@teststring!" # assertEquals "$output"  '@teststring!'
}

# stringIsEmpty()
# --------------------------------------------------------------#

@test "stringIsEmpty() with 'This is a TesT' should return 1 (false)" {
  run stringIsEmpty 'This is a TesT'
  assertFailure $status
}

@test "stringIsEmpty() with '\n' should return 1 (false)" {
  run stringIsEmpty '\n'
  assertFailure $status
}

BLANK=" "
@test "stringIsEmpty() with a blank string '$BLANK' should return 1 (false)" {
  run stringIsEmpty "$BLANK"
  assertFailure $status
}

EMPTY=""
@test "stringIsEmpty() with an empty string '$EMPTY' should return 0 (true)" {
  run stringIsEmpty "$EMPTY"
  assertSuccess $status
}

# stringRemovePrefix
# --------------------------------------------------------------#

@test "stringRemovePrefix() remove '../' from '../Cellar/gradle/4.2.1/' should return 'Cellar/gradle/4.2.1/'" {
  run stringRemovePrefix "../Cellar/gradle/4.2.1/" "../"
  assertSuccess $status
  assertEquals "$output" "Cellar/gradle/4.2.1/"
}