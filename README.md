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

# shouldly

[![pub package](https://img.shields.io/pub/v/shouldly.svg?label=shouldly&color=blue)](https://pub.dev/packages/shouldly)
[![codecov](https://codecov.io/gh/AndrewPiterov/shouldly/branch/dev/graph/badge.svg?token=VM9LTJXGQS)](https://codecov.io/gh/AndrewPiterov/shouldly)
[![likes](https://badges.bar/shouldly/likes)](https://pub.dev/packages/shouldly/score)
[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![Dart](https://github.com/AndrewPiterov/shouldly/actions/workflows/dart.yml/badge.svg)](https://github.com/AndrewPiterov/shouldly/actions/workflows/dart.yml)

`Shouldly` is an assertion framework which focuses on giving great error messages when the assertion fails while being simple and terse.

`shouldly` allows you write more readable test assertions.

## Features

* Better test failure messages
* More readable test code
* Conjunction support (`and`)
* Custom matchers

### Better test failure messages

To get more contextual information

```bash
// Non-Shouldly
Expected: <18>
  Actual: <17>

// Shouldly
Subject int should be
  `18`
but was
  `17`

// more with Shouldly 😍
customer.age should be
  `18`
but was
  `17`
```

```bash
// Non-Shouldly
Expected: not null
  Actual: <null>

// Shouldly
Subject should not be null
```

```bash
// Non-Shouldly
Expected: some element <4>
  Actual: [1, 2, 3, 5]

// Non-Shouldly
myList
    [1, 2, 3, 5]
should contain
    4
but does not
```

### Readability

More readable test code as an English sentence.

```dart
// without shouldly
expect(calculator.currentValue, 1);

// shouldly
calculator.currentValue.should.be(1);
```

You can mix up with **Expected** or **Actual** 🤔. But with `shouldly` there is no way to mix up.

```dart
// without shouldly
expect(playerCharacter.health, 100);
expect(100, playerCharacter.health);

// shouldly
playerCharacter.health.should.be(100);
```

### Conjunctions

This is a real English sentence, is it not?

```dart
13.should.beOdd().and.beGreaterOrEqualThan(13);

participants.should.contain('Andrew').and.not.contain('Bobby');

```

### Custom matchers

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

#### Or more exotic matchers

```dart
test('Custom matchers', () {
  final bobby = Customer(
    isMarried: true,
    gender: Gender.male,
  );
  bobby.should.beMale.and.beMarried;

  final kate = Customer(
    isMarried: true,
    gender: Gender.female,
  );
  kate.should.beMarried.and.not.beMale;
});
```

## Getting started

Simple add `shouldly` dependency into your project.

## Usage

### Booleans

```dart
test('false should be `false`', () {
  false.should.beFalse();
});

test('false should not be `true`', () {
  false.should.not.beTrue();
});
```

### Numbers

```dart
test('Int should be type of `int`', () {
  10.should.beOfType<int>();
  10.should.beAssignableTo<num>();
});
```

### Strings

```dart
test('should not start with substring', () {
  const str = 'Flutter';
  str.should.not.startWith('A');
});
```

### Iterables

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

```dart
test('should throw exact type of exception', () {
  throwExactException.should.throwException<CustomException>();
});

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

## Contributing

We accept the following contributions:

* Reporting issues
* Fixing bugs
* More tests
* More class integrations (Streams? Futures?)
* Improving documentation and comments

## Maintainers

* [Andrew Piterov](mailto:piterov1990@gmail.com?subject=[GitHub]%20Source%20Dart%20fluent_result)
