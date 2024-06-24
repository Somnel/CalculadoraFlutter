import 'package:flutter/material.dart';

Widget inputButton (Widget inputChild, Function() action) =>
  TextButton (
      style: ButtonStyle (
          backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
          elevation: const WidgetStatePropertyAll<double>(16.0),
          shadowColor: WidgetStatePropertyAll<Color?>(Colors.blueGrey[600]),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder (
                  borderRadius: BorderRadius.circular(8.0)
              )
          )
      ),
      onPressed: action,
      child: inputChild
  );