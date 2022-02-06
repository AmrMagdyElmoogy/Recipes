import 'package:flutter/animation.dart';

int ZERO = 0;
double Zero = 0.0;

extension IntegerNullability on int {
  int replaceNullOfIntegers() {
    if (this == null) {
      return ZERO;
    }
    return this;
  }
}

extension DoubleNullability on double {
  double replaceNullOfDoubles() {
    if (this == null) {
      return Zero;
    }
    return this;
  }
}

extension StringNullability on String {
  String replaceNullOfStrings() {
    if (this == null) {
      return "Not Defined";
    }
    return this;
  }
}