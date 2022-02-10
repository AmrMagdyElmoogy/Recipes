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

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}

extension StringExtensi on String {
    String toLower() {
      return "${this[0].toLowerCase()}${this.substring(1).toLowerCase()}";
    }
}