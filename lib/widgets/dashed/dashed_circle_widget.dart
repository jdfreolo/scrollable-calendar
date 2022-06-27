import 'package:flutter/material.dart';
import 'dashed_circle_painter.dart';

class DashedCircle extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double gapSize;
  final Color color;
  final int dashes;

  const DashedCircle({Key? key, required this.child, this.strokeWidth = 2.0, this.gapSize = 3.0, this.color = const Color(0xffffffff), this.dashes = 20}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return CustomPaint(
      painter: DashedCirclePainter(
        strokeWidth: strokeWidth,
        gapSize: gapSize,
        color: color,
        dashes: dashes,
      ),
      child: child,
    );
  }
}
