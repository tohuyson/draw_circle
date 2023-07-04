import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.fillColor,
    this.fillGradient,
    this.ringColor,
    this.ringGradient,
    this.strokeWidth,
    this.strokeCap,
    this.backgroundColor,
    this.isReverse,
    this.isReverseAnimation,
    this.backgroundGradient,
  }) : super(repaint: animation);

  final Animation<double>? animation;
  final Color? fillColor, ringColor, backgroundColor;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
  final bool? isReverse, isReverseAnimation;
  final Gradient? fillGradient, ringGradient, backgroundGradient;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ringColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;
    Paint paint1 = Paint()
      ..color = fillColor!
      ..strokeWidth = strokeWidth!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;

    if (ringGradient != null) {
      print("ringGradient is not null ");
      // final rect = Rect.fromCircle(
      //     center: size.center(Offset.zero), radius: size.width / 2);
      // paint.shader = ringGradient!.createShader(rect);
    } else {
      print("else ringGradient is not null ");
      // paint.shader = null;
    }

    double progress = (animation!.value) * 2 * math.pi;
    if (progress == 0) {
      print("progress $progress");
      paint.color = fillColor!;
    }

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    double startAngle = math.pi * 1.5;

    canvas.drawArc(Offset.zero & size, startAngle, progress, false, paint1);

    // if ((!isReverse! && isReverseAnimation!) ||
    //     (isReverse! && isReverseAnimation!)) {
    //   progress = progress * -1;
    //   startAngle = -math.pi / 2;
    // }

    if (fillGradient != null) {
      print("fillGradient is not null ");
      // final rect = Rect.fromCircle(
      //     center: size.center(Offset.zero), radius: size.width / 2);
      // paint.shader = fillGradient!.createShader(rect);
    } else {
      print("else fillGradient is not null ");
      // paint.shader = null;
      // paint.color = ringColor!;
    }

    // canvas.drawArc(Offset.zero & size, startAngle, progress, false, paint);

    if (backgroundColor != null || backgroundGradient != null) {
      print("backgroundColor or backgroundGradient is not null ");
      // final backgroundPaint = Paint();

      if (backgroundGradient != null) {
        print("backgroundGradient is not null ");
        // final rect = Rect.fromCircle(
        //     center: size.center(Offset.zero), radius: size.width / 2.2);
        // backgroundPaint.shader = backgroundGradient!.createShader(rect);
      } else {
        print("else backgroundGradient is not null ");
        // backgroundPaint.color = backgroundColor!;
      }
      // canvas.drawCircle(
      //     size.center(Offset.zero), size.width / 2.2, backgroundPaint);
    }
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value ||
        ringColor != oldDelegate.ringColor ||
        fillColor != oldDelegate.fillColor;
  }
}
