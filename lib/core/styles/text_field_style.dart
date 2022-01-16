import 'package:flutter/material.dart';

InputDecoration textFieldStyle({String hint = ""}){
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
      border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
      disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0)),
    hintText: hint,
    fillColor: Colors.white,
    focusColor: Colors.white,
    hoverColor: Colors.white,

    filled: true
  );
}