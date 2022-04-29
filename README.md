<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

<img src="https://raw.githubusercontent.com/andrewpiterov/shouldly/dev/doc/shouldly_logo.png" alt="shouldly logo" width="300"/>

[![pub package](https://img.shields.io/pub/v/shouldly.svg?label=shouldly&color=blue)](https://pub.dev/packages/shouldly)
[![codecov](https://codecov.io/gh/AndrewPiterov/shouldly/branch/dev/graph/badge.svg?token=VM9LTJXGQS)](https://codecov.io/gh/AndrewPiterov/shouldly)
[![likes](https://badges.bar/shouldly/likes)](https://pub.dev/packages/shouldly/score)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![Dart](https://github.com/AndrewPiterov/shouldly/actions/workflows/dart.yml/badge.svg)](https://github.com/AndrewPiterov/shouldly/actions/workflows/dart.yml)

`shouldly` is an assertion concept that focuses on

- writing assertions as plain English sentences
- and giving better error messages when the assertion fails while being simple and terse.

Inspired from [Fluent Assertion](https://fluentassertions.com/), [Shouldly](https://shouldly.io/), [should.js](https://shouldjs.github.io/)

## Features

- More readable test code
- Better test failure messages
- Conjunction support (`and`)
- Custom assertions

## Better readability

More readable test code as plain English sentence.

```dart
void main() {
  const playerCharacter = PlayerCharacter(
    'Arthur',
    100,
    ['Axe', 'Sword', 'Staff of Wonder'],
  );

  test('equality', () {
    // non shouldly
    expect(playerCharacter.health, 100);
    // 😍 shouldly
    playerCharacter.health.should.be(100);
  });

  test('array contains', () {
    // non shouldly
    expect(playerCharacter.weapons, contains('Staff of Wonder'));
    // 😍 shouldly
    playerCharacter.weapons.should.contain('Staff of Wonder');
  });

  test('nullability of string', () {
    // non shouldly
    expect(playerCharacter.nickname, isNotNull);
    // 😍 shouldly
    playerCharacter.nickname.should.not.beNullOrEmpty();
  });
}
```

<!-- <img src="https://raw.githubusercontent.com/andrewpiterov/shouldly/dev/example/img/eq.png" alt="drawing" width="300"/> -->

## Better test failure messages

To get more readable and contextual information.

<table border="0">
 <tr>
    <td><b style="font-size:30px">Non-Shouldly</b></td>
    <td><b style="font-size:30px">Shouldly</b></td>
 </tr>
 <tr>
    <td>
<pre>
Expected: <10>
  Actual: <100>
</pre>
    </td>
    <td>
<pre>
Expected playerCharacter.health
    should be
10
    but was
100
</pre>
    </td>
 </tr>
 <tr>
    <td>
<pre>
Expected: null
  Actual: 'Arthur'
</pre>
    </td>
    <td>
<pre>
Expected nickname
    should be null or empty
but was
    `Arthur`
</pre>
    </td>
 </tr>
 <tr>
    <td>
<pre>
Expected: contains 'Staff of Wonderr'
  Actual: ['Axe', 'Sword', 'Staff of Wonder']
</pre>
    </td>
    <td>
<pre>
Expected playerCharacter.weapons
    should contain
Staff of Wonder
    but was actually
[Axe, Sword]
</pre>
    </td>
 </tr>
</table>

## No more: Mix Up with parameters

You can mix up with **Expected** or **Actual** 🤔. But with `shouldly` there is no way to mix up.

```dart
// without shouldly
expect(playerCharacter.health, 0);
expect(0, playerCharacter.health);

// shouldly
playerCharacter.health.should.be(0);
```

## No more single heap of assertion methods

### Before

You could write such crazy assertions.

```dart
expect(2, isTrue);
expect(2, contains(2));
expect(2, startsWith('1'));
expect(2, isEmpty);
expect(2, throwsException);
```

### After

Every single type of class has his own assertions. Easy to find required assertion method.

## Conjunctions

This is a real English sentence, is it not?

```dart
13.should.beOdd().and.beGreaterOrEqualThan(13);
participants.should.contain('Andrew').and.not.contain('Bobby');
```

## SatisfyAllConditions

**satisfyAllConditions** will show all errors at once, not only first fail assertion.

```dart
test('should satisfy all conditions', () {
    Should.satisfyAllConditions([
      () => playerCharacter.nickname.should.as('nickname').not.beNullOrEmpty(),
      () => playerCharacter.weapons.should.as('weapons').contain('Staff of Wonder'),
      () => playerCharacter.health.should.as('health').be(100),
    ]);
  });
```

Example report can be:

```bash
Expected satisfy all conditions specified, but does not.
The following errors were found ...

------------- Error 1 -------------
Expected nickname
    should not be null or empty
but was
    ''

------------- Error 2 -------------
Expected weapons
    should contain
Staff of Wonder
    but was actually
[Axe, Sword]

------------- Error 3 -------------
Expected health
    should be
100
    but was
99

------------------------------------
```

## Custom matchers

### For existing one - just create an extension for it

```dart
extension CustomNumAssertions on NumericAssertions {
  NumericAssertions get beNegative {
    if (subject >= 0) {
      throw ShouldlyTestFailureError('Number\n  should be negative');
    }
    return NumericAssertions(subject);
  }
}
```

### Or more exotic matchers - fot custom types

1. First, create a Assertions class for your custom type which extends `BaseAssertions`

```dart
class CustomerAssertions extends BaseAssertions<Customer, CustomerAssertions> {
  // ...

  CustomerAssertions get beMarried {
    if (isReversed) {
      if (subject!.isMarried) {
        throw ShouldlyTestFailureError('Customer should not be married');
      }
    } else {
      if (!subject!.isMarried) {
        throw ShouldlyTestFailureError('Customer should be married');
      }
    }
    return CustomerAssertions(subject);
  }

  CustomerAssertions get beMale {
    if (isReversed) {
      Execute.assertion
          .forCondition(subject!.gender == Gender.male)
          .failWith('$subjectLabel should not be male');
    } else {
      Execute.assertion
          .forCondition(subject!.gender != Gender.male)
          .failWith('$subjectLabel should be male');
    }

    Execute.assertion
        .forCondition(subject!.gender != Gender.male)
        .failWith('$subjectLabel should be male');

    return CustomerAssertions(subject);
  }

  // ...
}
```

2. Second, create an extension on your class which has `should` property with type of your custom assertions class

```dart
extension CustomerExtension on Customer {
  CustomerAssertions get should => CustomerAssertions(this);
}
```

3. Third, you are ready to go use your own `shouldly` assertions

```dart
test('Custom matchers', () {
  bobby.should.beMale.and.beMarried;
  kate.should.beMarried.and.not.beMale;
});
```

## Complete in

To verify how long your function is executed

```dart
test('should complete in a duration', () async {
  await Should.completeIn(
    Duration(seconds: 1),
    func: () => slowFunction(
      Duration(milliseconds: 900),
    ),
  );
});

test('should complete after a period of time', () async {
  await Should.completeAfter(
    const Duration(seconds: 3),
    func: () => verySlowFunction(
      const Duration(seconds: 4),
    ),
  );
});
```

## Getting started

Simple add `shouldly` dependency into your project.

```yaml
dev_dependencies:
  shouldly: <latest>
```

## Usage

### Objects

Every single object has following assertion methods:

| Method             | Example                               | Failure message                      |
| ------------------ | ------------------------------------- | ------------------------------------ |
| **be**             | ```1.should.be(2);```                 | Expected `int` should be 2 but was 1 |
| **beOfType**       | ```2.0.should.beOfType<double>();```  |
| **beAssignableTo** | ```3.should.beAssignableTo<int>();``` |
| **beNull**         | ```null.should.beNull();```           |
| **beOneOf**        | ```5.should.beOneOf([1, 2, 5]);```    |

```dart
test('should be not null', () {
  final obj = Object();
  obj.should.not.beNull();
});

test('should be null', () {
  const Object? obj = null;
  obj.should.beNull();
});

test('should be type of `int`', () {
  const obj = 1;
  obj.should.beOfType<int>();
});

test('should be assignable to `num`', () {
  const obj = 1;
  obj.should.beAssignableTo<num>();
});
```

### Booleans

| Method      | Example                           | Failure message                                    |
| ----------- | --------------------------------- | -------------------------------------------------- |
| **beTrue**  | ```false.should.beTrue();```      | Target `boolean` should be True but was False      |
| **beFalse** | ```false.should.not.beFalse();``` | Target `boolean` should not be False but was False |

```dart
test('false should be `false`', () {
  false.should.beFalse();
});

test('false should not be `true`', () {
  false.should.not.beTrue();
});
```

### Numbers

| Method                   | Example                                            | Failure message                                        |
| ------------------------ | -------------------------------------------------- | ------------------------------------------------------ |
| **bePositive**           | ```(-1).should.bePositive();```                    | Target `int` should be positive but was negative as -1 |
| **beNegative**           | ```1.should.beNegative();```                       | Target `int` should be negative but was positive as 1  |
| **beZero**               | ```10.should.beZero();```                          | Target `int` should be 0 but was 10                    |
| **beOdd**                | ```8.should.beOdd();```                            | Target `int` should be odd but was even as 8           |
| **beEven**               | ```7.should.beEven();```                           | Target `int` should be event but was odd as 7          |
| **beGreaterThan**        | ```1.should.beGreaterThan(2);```                   | Target `int` should be greater than 2 but does not     |
| **beAbove**              | ```3.should.beAbove(2);```                         |
| **beLessThan**           | ```3.should.beLessThan(4);```                      |
| **beBelow**              | ```3.should.beBelow(4);```                         |
| **beGreaterOrEqualThan** | ```3.should.beGreaterOrEqualThan(3);```            |
| **beLessOrEqualThan**    | ```3.should.beLessOrEqualThan(3);```               |
| **beWithin**             | ```3.should.beWithin(1,5);```                      |
| **beCloseTo**            | ```pi.should.beCloseTo(3.14, delta: 0.01);```      |
| **beTolerantOf**         | ```pi.should.beTolerantOf(3.14, tolerance: 1%);``` |

```dart
test('Int should be type of `int`', () {
  2.should.beEven();
  10.should.beGreaterThan(9);
  9.99.should.not.beCloseTo(10.0, delta: 0.01);
});
```

### Strings

| Method                 | Example                                      | Failure message |
| ---------------------- | -------------------------------------------- | --------------- |
| **startWith**          | ```'Flutter'.should.startWith('f');```       |                 |
| **endWith**            | ```'Flutter'.should.endWith('a');```         |                 |
| **haveLength**         | ```'Flutter'.should.haveLength(10);```       |                 |
| **beNullOrEmpty**      | ```'Flutter'.should.beNullOrEmpty();```      |                 |
| **beNullOrWhiteSpace** | ```'Flutter'.should.beNullOrWhiteSpace();``` |                 |
| **beBlank**            | ```'Flutter'.should.beBlank();```            |                 |
| **match**              | ```'Flutter'.should.match('*a');```          |                 |
| **contain**            | ```'Flutter'.should.contain('a');```         |                 |

```dart
test('should not start with substring', () {
  'Flutter'.should.not.startWith('A');
});
```

### DateTimes

| Method        | Example                                                  | Failure message |
| ------------- | -------------------------------------------------------- | --------------- |
| **beCloseTo** | ```DateTime.now().should.beCloseTo(Date(2025, 1, 1));``` |                 |
| **beAfter**   | ```DateTime.now().should.beCloseTo(Date(2022, 1, 1));``` |                 |
| **beBefore**  | ```DateTime.now().should.beBefore(Date(2222, 1, 1));```  |                 |

```dart
// before
DateTime(2021, 9, 9).should.beBefore(DateTime(2021, 9, 10));
DateTime(2021, 9, 9).should.not.beBefore(DateTime(2021, 9, 9));

// close to
DateTime(2021, 9, 9, 1, 1, 1, 2).should.beCloseTo(
      DateTime(2021, 9, 9, 1, 1, 1, 3),
      delta: Duration(milliseconds: 1),
    );
```

### Iterables

| Method         | Example                                      | Failure message |
| -------------- | -------------------------------------------- | --------------- |
| **haveCount**  | ```[1, 2, 3].should.haveCount(7);```         |                 |
| **contain**    | ```[1, 2, 3].should.contain(7);```           |                 |
| **containAll** | ```[1, 2, 3].should.containAll([7, 8]);```   |                 |
| **every**      | ```[1, 2, 3].should.every((x) => x > 10);``` |                 |
| **any**        | ```[1, 2, 3].should.any((x) => x == 0);```   |                 |

```dart
test('should contain', () {
  [1, 200, 3].should.contain(200);
});

test('should not contain', () {
  [1, 2, 4].should.not.contain(3);
});

test('with every element in collection is true for predicate', () {
  [3, 5, 7, 9].should.every((item) => item < 10);
});

test('with some elements in collection is true for predicate', () {
  [3, 5, 7, 9].should.any((item) => item > 8);
});
```

### Maps

| Method                  | Example                                               | Failure message |
| ----------------------- | ----------------------------------------------------- | --------------- |
| **haveCount**           | ```{}.should.haveCount(7);```                         |                 |
| **beEmpty**             | ```{}.should.beEmpty();```                            |                 |
| **containKey**          | ```{'name': 'Bobby'}.should.containKey('age');```     |                 |
| **containKeys**         | ```{}.should.containKeys(['age', 'name']);```         |                 |
| **haveValueInKey**      | ```{}.should.haveValueInKey('name');```               |                 |
| **containKeyWithValue** | ```{}.should.containKeyWithValue('name', 'Bobby');``` |                 |
| **contain**             | ```{}.should.haveValueInKey(<MapEntry>[]);```         |                 |

```dart
final subject = {
  'name': 'John',
  'age': 18,
};

test('should contain key', () {
  subject.should.containKey('name');
});

test('should contain key with exact value', () {
  subject.should.containKeyWithValue('age', 18);
});
```

### Functions

| Method                | Example                                                         | Failure message |
| --------------------- | --------------------------------------------------------------- | --------------- |
| **throwException**    | ```Should.throwException(() => myFunc());```                    |                 |
| **notThrowException** | ```Should.notThrowException(() => myFunc());```                 |                 |
| **throwError**        | ```Should.throwError(() => myFunc());```                        |                 |
| **notThrowError**     | ```Should.notThrowError(() => myFunc());```                     |                 |
| **completeIn**        | ```Should.completeIn(Duration(seconds: 1),  () => myFunc());``` |                 |

```dart
Should.throwException(() => someMethodWitchThrowException(params:));
Should.throwError<ExactError>(() => someMethodWitchThrowExactError(params:));
```

```dart
test('async function should throw exception', () async {
  await Should.throwAsync(() {
    Future.delayed(Duration(milliseconds: 100));
    throw Exception('test');
  });
});

test('async function should throw exact exception', () async {
  await Should.throwAsync<CustomException>(() {
    Future.delayed(Duration(milliseconds: 100));
    throw CustomException('custom exception test');
  });
});

test('should complete in a duration', () async {
  await Should.completeIn(
    Duration(seconds: 1),
    func: () => slowFunction(
      Duration(milliseconds: 900),
    ),
  );
});
```

### Enums

```dart
test('should not be equal', () {
  seasons.spring.should.not.be(seasons.winter);
});

test('should not be type of', () {
  seasons.spring.should.not.beOfType<level>();
});

test('should be assignable to `Enum`', () {
  seasons.spring.should.beAssignableTo<Enum>();
});
```

More examples [here](./example/README.md)

## Writing Custom Matchers

```dart
extension CustomerExtension on Customer {
  CustomerAssertions get should => CustomerAssertions(this);
}

class CustomerAssertions extends BaseAssertions<Customer, CustomerAssertions> {
  CustomerAssertions(
    Customer? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

  CustomerAssertions get beMarried {
    if (isReversed) {
      if (subject!.isMarried) {
        throw ShouldlyTestFailure('Customer should not be married');
      }
    } else {
      if (!subject!.isMarried) {
        throw ShouldlyTestFailure('Customer should be married');
      }
    }
    return CustomerAssertions(subject);
  }

  CustomerAssertions get beMale {
    if (isReversed) {
      if (subject!.gender == Gender.male) {
        throw ShouldlyTestFailure('Customer should be female');
      }
    } else {
      if (subject!.gender != Gender.male) {
        throw ShouldlyTestFailure('Customer should be male');
      }
    }

    return CustomerAssertions(subject);
  }

  @override
  CustomerAssertions copy(
    Customer? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) =>
      CustomerAssertions(
        subject,
        isReversed: isReversed,
        subjectLabel: subjectLabel,
      );
}
```

## Recommendations

You can improve the readability of the rest of your test code with [given_when_then_unit_test](https://pub.dev/packages/given_when_then_unit_test), which enhances the test report readability as well.

<img src="https://raw.githubusercontent.com/andrewpiterov/shouldly/dev/example/img/shouldly_with_gwtut.png" alt="drawing" width="600"/>

## Changelog

Please see the [Changelog](CHANGELOG.md) page to know what's recently changed.

## Contributing

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/AndrewPiterov/date_time/issues/new).\
If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/AndrewPiterov/date_time/pulls).

We accept the following contributions:

- Ideas how to improve
- [Reporting issues](https://github.com/AndrewPiterov/shouldly/issues/new)
- Fixing bugs
- More tests
- More class integrations (Functions, Futures, Streams, Durations)
- Improving documentation and comments

## Maintainers

- [Andrew Piterov](mailto:contact@andrewpiterov.com?subject=[GitHub]%20Source%20Dart%20shouldly)

<!-- <a href="https://www.buymeacoffee.com/devcraft.ninja" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Support me" height="41" width="174"></a> -->
