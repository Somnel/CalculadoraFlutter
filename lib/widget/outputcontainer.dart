import 'package:flutter/material.dart';

Widget outputContainer(String output) =>
    Container (
      alignment: Alignment.centerRight,
      color: Colors.grey[700],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
        child: Text(
          output,
          style: const TextStyle (
              color: Colors.white,
              fontSize: 32,
              letterSpacing: 2.0
          ),
        ),
      ),
    );