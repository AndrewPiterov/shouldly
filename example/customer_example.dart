import 'package:shouldly/shouldly.dart';

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
    Customer? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) : super(subject, isReversed: isReversed, subjectLabel: subjectLabel);

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
          .failWith('Customer should not be male');
    } else {
      Execute.assertion
          .forCondition(subject!.gender != Gender.male)
          .failWith('Customer should be male');
    }

    Execute.assertion
        .forCondition(subject!.gender != Gender.male)
        .failWith('Customer should be male');

    return CustomerAssertions(subject);
  }

  @override
  CustomerAssertions copy(
    Customer? subject, {
    bool isReversed = false,
    String? subjectLabel,
  }) {
    return CustomerAssertions(
      subject,
      isReversed: isReversed,
      subjectLabel: subjectLabel,
    );
  }
}
