import 'package:flutter/material.dart';

ColorController colorController = ColorController(Colors.red);

///Observer Class
class ColorController extends ValueNotifier<Color> {
  ColorController(super._value);

  void updateColor(Color newColor) {
    value = newColor;
  }

  void updateOpacity(double opacity) {
    value = value.withValues(alpha: opacity);
  }

  double get colorAlpha {
    return value.a;
  }
}
