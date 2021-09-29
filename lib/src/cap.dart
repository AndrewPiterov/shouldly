class Cap<T> {
  final T target;
  final bool isReversed;
  Cap(this.target, {this.isReversed = false});

  Cap<T> be(Object value) {
    if (isReversed) {
      return Cap(this.target);
    }

    if (value != this.target) {
      throw Exception(
          'target should be\n  `$value`\nbut was\n  `${this.target}`');
    }

    return Cap(this.target);
  }

  Cap<T> equal(Object value) {
    if (isReversed) {
      return Cap(this.target);
    }

    if (value != this.target) {
      throw Exception('should be\n  `$value`\nbut was\n  `${this.target}`');
    }

    return Cap(this.target);
  }

  void beTypeOf<K>() {
    if (isReversed) {
      if (target is K) {
        throw Exception('Type of value `$T` should be type of `$K`');
      }
      return;
    }

    if (target is! K) {
      throw Exception('Value should be Type of `$K`');
    }
  }

  Cap<T> get and => Cap<T>(target, isReversed: isReversed);

  Cap<T> get not => Cap<T>(target, isReversed: true);
}
