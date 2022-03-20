library swipe_effect;

import 'package:flutter/material.dart';

class SwipeEffect extends StatefulWidget {
  final Color color;
  final Widget child;
  final TextDirection direction;
  final double verticalTolerance;
  final double callbackDeltaRatio;
  final double startDeltaPx;

  ///
  /// SwipeEffect constructor
  /// [child] Your child widget.
  /// [callback] A call back will be triggered after the swipe action.
  /// [color] Color of the effect curve.
  /// [direction] direction of the swipe `TextDirection.ltr` or`TextDirection.rtl`
  /// [verticalTolerance] Double value determines a ratio from the screen height that after swiping in vertical axis the effect will be dismissed.
  /// [callbackDeltaRatio] Double value determines a ratio from the screen width to trigger the callback after reaching it.
  /// [startDeltaPx] Determines where to start the effect from the beginning of the widget (in pixel)
  ///

  const SwipeEffect({
    Key? key,
    this.color = Colors.cyanAccent,
    required this.child,
    required this.callback,
    this.direction = TextDirection.rtl,
    this.verticalTolerance = 0.1,
    this.callbackDeltaRatio = 0.25,
    this.startDeltaPx = 30,
  }) : super(key: key);

  @override
  State<SwipeEffect> createState() => _SwipeEffectState();

  final VoidCallback callback;
}

class _SwipeEffectState extends State<SwipeEffect> {
  late Offset point;
  late Offset start;
  late Size size;
  late double startX;
  bool isDragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    startX = widget.direction == TextDirection.rtl ? size.width : 0;
    point = Offset(startX, 0);
    start = Offset.zero;
  }

  ///
  /// Detects the swipe gesture and builds a "CustomPaint" widget based on that gesture.
  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            isDragging =
                (startX - details.localPosition.dx).abs() < widget.startDeltaPx;
            start = details.localPosition;
          },
          onHorizontalDragEnd: (details) {
            var tt = (startX - point.dx).abs();
            if (isDragging && tt > size.width * widget.callbackDeltaRatio) {
              widget.callback();
            }
            setState(() {
              isDragging = false;
              point = Offset(startX, 0);
              start = Offset.zero;
            });
          },
          onHorizontalDragUpdate: (details) {
            if ((startX - start.dx).abs() > widget.startDeltaPx) return;
            if ((start.dy - details.localPosition.dy).abs() >
                size.height * widget.verticalTolerance) {
              setState(() {
                point = Offset(startX, 0);
                start = const Offset(0, 0);
              });
              return;
            }
            setState(() {
              point = details.globalPosition;
            });
          },
          child: CustomPaint(
            size: Size.infinite,
            foregroundPainter:
                BackEffect(point, widget.color, widget.direction),
            child: widget.child,
          ),
        ));
  }

  @override
  void didUpdateWidget(covariant SwipeEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction != oldWidget.direction) {
      setState(() {
        startX = widget.direction == TextDirection.rtl ? size.width : 0;
        point = Offset(startX, 0);
        start = Offset.zero;
      });
    }
  }
}

class BackEffect extends CustomPainter {
  Offset dragPoint;
  Color color;
  TextDirection direction;

  BackEffect(this.dragPoint, this.color, this.direction);

  /// Draws path with the given [size].
  ///
  /// The path is filled with [color] and starts in [direction]
  /// The path is a combination of two quadratic curves, to add the swipe effect.
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final dy = size.height / 5;
    final double startX = direction == TextDirection.rtl ? size.width : 0;
    final p0 = Offset(startX, 0);
    final p3 = dragPoint;
    final p6 = Offset(startX, size.height);
    final p1 = Offset(p0.dx, p0.dy + dy);
    final p2 = Offset(p3.dx, p3.dy - dy);
    final p4 = Offset(p3.dx, p3.dy + dy);
    final p5 = Offset(p6.dx, p6.dy - dy);
    final path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy)
      ..cubicTo(p4.dx, p4.dy, p5.dx, p5.dy, p6.dx, p6.dy)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
