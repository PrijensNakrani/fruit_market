import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FruitText extends StatelessWidget {
  const FruitText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Fruit Market",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22.sp, color: Colors.white),
    );
  }
}
