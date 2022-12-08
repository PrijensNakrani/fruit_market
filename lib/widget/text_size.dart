import 'package:flutter/material.dart';

class TextSize extends StatelessWidget {
  final text;
  final color;
  final size;
  final weight;
  const TextSize(
      {Key? key, required this.text, this.color, this.size, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
