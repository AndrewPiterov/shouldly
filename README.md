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
[![likes](https://badges.bar/shouldly/likes)](https://pub.dev/packages/shouldly/score)
![building](https://github.com/AndrewPiterov/shouldly/workflows/build/badge.svg)

`Shouldly` is an assertion framework which focuses on giving great error messages when the assertion fails while being simple and terse.

`shouldly` allows you write more readable test assertions.

## Features

* Better test failure messages
* More readable test code
* Conjunction support (`and` only for now)
* Custom matchers

### Better test failure messages

To get more contextual information

```bash
// Non-Shouldly
Expected: <18>
  Actual: <17>

// Shouldly
Target int should be
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
Target should not be null
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
extension CustomNumberExtensions on Cap<num> {
  Cap<num> get beNegative {
    if (value >= 0) {
      throw ShouldlyTestFailure('Value\n  should be negative\n  but was\n$value');
    }
    return Cap(value);
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
test('Int should be type of `num`', () {
  10.should.beTypeOf<num>();
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
final target = {
  'name': 'John',
  'age': 18,
};

test('should contain key', () {
  target.should.containKey('name');
});

test('should contain key with exact value', () {
  target.should.containKeyWithValue('age', 18);
});
```

### Functions

```dart
test('should not throw throw an exception', () {
  someMethod.should.notThrowException();
});

test('should throw exact type of exception', () {
  throwExactException.should.throwExact<CustomException>();
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
class Customer {
  final bool isMarried;
  final Gender gender;

  Customer(this.isMarried, this.gender);
}

extension CustomerExtension on Customer {
  Cap<Customer> get should => Cap<Customer>(this);
}

extension CustomerMatcherExtension on Cap<Customer> {
  Cap<Customer> get beMarried {
    if (!target.isMarried) {
      throw ShouldlyTestFailure('target should be married');
    }
    return Cap(target);
  }

  Cap<Customer> get beMale {
    if (isReversed) {
      if (target.gender == Gender.male) {
        throw ShouldlyTestFailure('target should be female');
      }
    } else {
      if (target.gender != Gender.male) {
        throw ShouldlyTestFailure('target should be male');
      }
    }

    return Cap(target);
  }
}
```

## Contributing

We accept the following contributions:

* Reporting issues
* Fixing bugs
* More tests
* Conjunction support (see: should.js and/or) (and conjunctions complete)
* More class integrations (Streams? Futures?)
* Improving documentation and comments

## Maintainers

* [Andrew Piterov](mailto:piterov1990@gmail.com?subject=[GitHub]%20Source%20Dart%20fluent_result)
