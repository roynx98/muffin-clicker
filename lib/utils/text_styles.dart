import 'package:flutter/material.dart';

const textShadows = [
  Shadow(
    color: Colors.black,
    offset: Offset(2, 2),
    blurRadius: 2,
  )
];

const levelLabelTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  shadows: textShadows,
);
