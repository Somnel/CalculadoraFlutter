import 'package:flutter/material.dart';

Widget inputContainer(final Widget input) {
  return Container (
    decoration: ShapeDecoration (
        color: Colors.grey[900],
        shape: const RoundedRectangleBorder (
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))
        )
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 16.0),
      child: input,
    ),
  );
}