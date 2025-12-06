import 'package:flutter/material.dart';

class Errortext extends StatelessWidget {
  final String errorMessage;
  Errortext({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red, fontSize: 16),
    );
  }
}
