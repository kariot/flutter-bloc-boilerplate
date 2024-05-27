import 'package:flutter/material.dart';

InputDecoration getInputDecoration(String? hint) {
  return InputDecoration(
    border: const UnderlineInputBorder(),
    labelText: hint,
  );
}
