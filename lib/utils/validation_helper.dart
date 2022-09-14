import 'package:flutter/services.dart';

class ValidationHelpers{
  static List<TextInputFormatter>? inputFormatter(String text) {
    List<TextInputFormatter>? val;
    switch (text) {
      case "name":
        val = [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))];
        break;
    }
    return val;
  }

}