import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innerColor;
  final outerColor;

  final child;

  const MyPath({
    this.child,
    this.innerColor,
    this.outerColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: outerColor,
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(4),
            color: innerColor,
            child: child,
          ),
        )),
      ),
    );
  }
}
