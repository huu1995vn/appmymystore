import 'package:flutter/material.dart';
import 'package:mymystore/core/utilities/app_colors.dart';

/*
Application use
 Widget _circularBackground() {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      child: new CustomPaint(
        painter: new CircularBackgroundPainter(),
      ),
    );
  }
*/

class CircularBackgroundPainter extends CustomPainter {
  final Paint mainPaint;
  final Paint middlePaint;
  final Paint lowerPaint;

  CircularBackgroundPainter()
      : mainPaint = Paint(),
        middlePaint = Paint(),
        lowerPaint = Paint() {
    mainPaint.color = AppColors.primary;
    mainPaint.isAntiAlias = true;
    mainPaint.style = PaintingStyle.fill;

    middlePaint.color = AppColors.primary500;
    middlePaint.isAntiAlias = true;
    middlePaint.style = PaintingStyle.fill;

    lowerPaint.color = AppColors.primary100;
    lowerPaint.isAntiAlias = true;
    lowerPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    //canvas.translate(radius, radius);

    drawBellAndLeg(radius, canvas, size);

    canvas.restore();
  }

  void drawBellAndLeg(radius, canvas, Size size) {  
    Path upperPath = Path();
    upperPath.addRect(Rect.fromLTRB(0, 0, size.width, size.height / 4));
    upperPath.addArc(
        Rect.fromLTRB(-140, 40, size.width + 50, size.height / 1.95), 0.1, 30);

    Path middlePath = Path();
    middlePath.addRect(Rect.fromLTRB(0, 0, size.width, size.height / 4));
    middlePath.addArc(
        Rect.fromLTRB(-135, 0, size.width + 50, size.height / 2.2), 0.1, 30);

    Path lowerPath = Path();
    //path1.lineTo(size.width, 0);
    //path1.lineTo(size.width, size.height / 3);
    //path1.addOval(Rect.fromLTRB(-150, 100, size.width + 50, size.height / 2));
    lowerPath.addRect(Rect.fromLTRB(0, 0, size.width, size.height / 5));
    lowerPath.addArc(
        Rect.fromLTRB(-150, -100, size.width + 50, size.height / 2.5), 0.1, 30);

    //path1.quadraticBezierTo(0, size.height / 3, size.width, size.height / 3);

    canvas.drawPath(upperPath, lowerPaint);
    canvas.drawPath(middlePath, middlePaint);
    canvas.drawPath(lowerPath, mainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}