import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(''),),
      body: Center(
      child: CustomPaint( //                       <-- CustomPaint widget
        size: Size(300, 300),
        painter: MyPainter(),
      ),
    ),
    );
  }
}
class MyPainter extends CustomPainter { //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
  final pointMode = ui.PointMode.polygon;
  final points = [
    Offset(50, 100),
    Offset(150, 75),
    Offset(250, 250),
    Offset(130, 200),
    Offset(270, 100),
  ];
  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;
  canvas.drawPoints(pointMode, points, paint);
}

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}