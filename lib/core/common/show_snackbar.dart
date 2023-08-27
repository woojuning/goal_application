import 'package:flutter/material.dart';

void showSnackBar(String error, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
}
