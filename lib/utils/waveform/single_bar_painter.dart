import 'package:flutter/material.dart';

class SingleBarPainter extends CustomPainter {
  static Color barColor = Colors.transparent;
  final Color backgroundColor;
  final double singleBarWidth;
  final double barBorderRadius;
  final Paint trackPaint;
  final Paint aboveAndBelowPaint;
  final double maxSeekBarHeight;
  final double actualSeekBarHeight;
  final double startingPosition;
  final double heightOfContainer;
  final double gap;

  SingleBarPainter({
    required this.backgroundColor,
    this.barBorderRadius = 0,
    required this.singleBarWidth,
    required this.maxSeekBarHeight,
    required this.actualSeekBarHeight,
    required this.heightOfContainer,
    this.gap = 0.2,
    required this.startingPosition,
  })  : assert(gap > 0.0 && gap < 1.0),
        trackPaint = Paint()
          ..color = barColor
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.fill,
        aboveAndBelowPaint = Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerSideHeight = maxSeekBarHeight - actualSeekBarHeight;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(startingPosition, -heightOfContainer / 1.9,
              singleBarWidth + 0.5, outerSideHeight),
          const Radius.circular(0),
        ),
        aboveAndBelowPaint);

    if (startingPosition == 0) {
      canvas.drawRRect(
          RRect.fromLTRBR(startingPosition, -heightOfContainer / 1.9,
              singleBarWidth + 0.5, outerSideHeight, const Radius.circular(0)),
          Paint()
            ..color = backgroundColor
            ..style = PaintingStyle.stroke);
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            startingPosition,
            outerSideHeight / 2 - heightOfContainer / 2,
            singleBarWidth,
            actualSeekBarHeight / 2),
        const Radius.circular(0),
      ),
      trackPaint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(startingPosition, -heightOfContainer / 2,
            gap * singleBarWidth, heightOfContainer),
        const Radius.circular(0),
      ),
      aboveAndBelowPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
