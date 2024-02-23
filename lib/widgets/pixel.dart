import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final innerColor;
  final outerColor;
  final child;

  const MyPixel({this.child,this.innerColor,this.outerColor});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(1),
    child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Container(
      color: outerColor,
      child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Container(padding: EdgeInsets.all(4),color: innerColor,child: child,),)),),
    );
  }
}

//ClipRrect contain container and has color and the child is cliprect which has innercolor and a child
