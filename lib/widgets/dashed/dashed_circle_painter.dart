import 'dart:math';
import 'package:flutter/material.dart';

class DashedCirclePainter extends CustomPainter{
  final double strokeWidth;
  final double gapSize;
  final Color color;
  final int dashes;

  const DashedCirclePainter({required this.strokeWidth, required this.gapSize, required this.color, required this.dashes});

  @override
  void paint(Canvas canvas, Size size){
    final double gap = pi / 180 * gapSize;
    final double angle = (pi * 2) / dashes;

    for(int i = 0; i < dashes; i++){
      final Paint paint = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(Offset.zero & size, gap + angle * i, angle - gap * 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(DashedCirclePainter oldDelegate){
    return dashes != oldDelegate.dashes || color != oldDelegate.color;
  }
}