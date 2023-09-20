
import 'package:flutter/material.dart';

InputDecoration buildInputDecorationTextField({labelName}) {
  return InputDecoration(labelText: labelName,   border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),);
}