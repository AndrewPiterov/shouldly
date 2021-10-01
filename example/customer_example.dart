import 'package:shouldly/shouldly.dart';
import 'package:shouldly/src/exception.dart';

class Customer {
  final bool isMarried;
  final Gender gender;

  ///
  // ignore: avoid_positional_boolean_parameters
  Customer(this.isMarried, this.gender);
}

enum Gender {
  male,
  female,
}

extension CustomerExtension on Customer {
  CustomerAssertions get should => CustomerAssertions(this);
}

class CustomerAssertions extends BaseAssertions<Customer, CustomerAssertions> {
  CustomerAssertions(
    Customer? target, {
    bool isReversed = false,
    String? targetLabel,
  }) : super(target, isReversed: isReversed, targetLabel: targetLabel);

  CustomerAssertions get beMarried {
    if (isReversed) {
      if (target!.isMarried) {
        throw ShouldlyTestFailure('Customer should not be married');
      }
    } else {
      if (!target!.isMarried) {
        throw ShouldlyTestFailure('Customer should be married');
      }
    }
    return CustomerAssertions(target);
  }

  CustomerAssertions get beMale {
    if (isReversed) {
      if (target!.gender == Gender.male) {
        throw ShouldlyTestFailure('Customer should be female');
      }
    } else {
      if (target!.gender != Gender.male) {
        throw ShouldlyTestFailure('Customer should be male');
      }
    }

    return CustomerAssertions(target);
  }

  @override
  CustomerAssertions copy(
    Customer? target, {
    bool isReversed = false,
    String? targetLabel,
  }) =>
      CustomerAssertions(
        target,
        isReversed: isReversed,
        targetLabel: targetLabel,
      );
}
