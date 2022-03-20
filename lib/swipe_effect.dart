library swipe_effect;

import 'package:flutter/material.dart';

class SwipeEffect extends StatefulWidget {
  final Color color;
  final Widget child;
  final TextDirection direction;
  final double verticalTolerance;
  final double callbackDeltaRatio;
  final double startDeltaPx;

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
