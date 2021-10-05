import 'package:shouldly/shouldly.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

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

void main() {
  test('Customer should be male', () {
    final andrew = Customer(false, Gender.male);

    expect(andrew.isMarried, isFalse);
    andrew.gender.should.be(Gender.male);
  });

  test('Custom model (without its assertions) is not null', () {
    Contact().should.not.beNull();
  });
}

class Contact {}
