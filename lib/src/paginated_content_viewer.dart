import 'package:flutter/material.dart';

class PaginatedContentViewer extends StatelessWidget {
  const PaginatedContentViewer({
    super.key,
    required this.pageController,
    required this.children,
    this.dotFillColor = const Color(0x20000000),
    this.dotOutlineColor = const Color(0x6F000000),
    this.indicatorColor = Colors.redAccent,
    this.dotRadius = 10.0,
    this.dotOutlineThickness = 3.0,
    this.spacing = 20.0,
    this.onPageChanged,
  });

  final PageController pageController;
  final List<Widget> children;
  final Color dotFillColor;
  final Color dotOutlineColor;
  final Color indicatorColor;
  final double dotRadius;
  final double dotOutlineThickness;
  final double spacing;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int page) {
            onPageChanged?.call(page);
          },
          children: children,
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: pageController,
            builder: (context, snapshot) => CustomPaint(
              painter: _PageIndicatorPainter(
                pageCount: children.length,
                dotRadius: dotRadius,
                dotOutlineThickness: dotOutlineThickness,
                spacing: spacing,
                scrollPosition: pageController.hasClients && pageController.page != null
                    ? pageController.page!
                    : 0.0,
                dotFillColor: dotFillColor,
                dotOutlineColor: dotOutlineColor,
                indicatorColor: indicatorColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PageIndicatorPainter extends CustomPainter {
  _PageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    required this.spacing,
    required this.scrollPosition,
    required Color dotFillColor,
    required Color dotOutlineColor,
    required Color indicatorColor,
  })  : dotFillPaint = Paint()..color = dotFillColor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor;

  final int pageCount;
  final double dotRadius;
  final double dotOutlineThickness;
  final double spacing;
  final double scrollPosition;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double totalWidth =
        (pageCount * (2 * dotRadius)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);
    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final int pageIndexToLeft = scrollPosition.floor();
    final double leftDotX = (center.dx - (totalWidth / 2)) +
        (pageIndexToLeft * ((2 * dotRadius) + spacing));
    final double transitionPercent = scrollPosition - pageIndexToLeft;

    final double laggingLeftPositionPercent =
        (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;
    final double indicatorLeftX =
        leftDotX + (laggingLeftPositionPercent * ((2 * dotRadius) + spacing));

    final double acceleratedRightPositionPercent =
    (transitionPercent * 2).clamp(0, 1.0);
    final double indicatorRightX = leftDotX +
        (acceleratedRightPositionPercent * ((2 * dotRadius) + spacing)) +
        2 * dotRadius;

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        -dotRadius,
        indicatorRightX,
        dotRadius,
        Radius.circular(dotRadius),
      ),
      indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWidth) {
    Offset dotCenter = center.translate((-totalWidth / 2) + dotRadius, 0);

    for (int i = 0; i < pageCount; ++i) {
      _drawDot(canvas, dotCenter);
      dotCenter = dotCenter.translate((2 * dotRadius) + spacing, 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(dotCenter, dotRadius - dotOutlineThickness, dotFillPaint);

    Path outlinePath = Path()
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius))
      ..addOval(Rect.fromCircle(
          center: dotCenter, radius: dotRadius - dotOutlineThickness))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
