library swipe_effect;

import 'package:flutter/material.dart';

class SwipeEffect extends StatefulWidget {
  final Color color;
  final Widget child;

  const SwipeEffect({
    Key? key,
    this.color = Colors.cyanAccent,
    required this.child,
    required this.callback,
  }) : super(key: key);

  @override
  State<SwipeEffect> createState() => _SwipeEffectState();

  final VoidCallback callback;
}

class _SwipeEffectState extends State<SwipeEffect> {
  Offset point = const Offset(0, 0);
  Offset start = const Offset(0, 0);
  late Size size;
  bool isDragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    point = Offset(size.width, 0);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            isDragging = size.width - details.localPosition.dx < 30;
            start = details.localPosition;
          },
          onHorizontalDragEnd: (details) {
            var tt = size.width - point.dx;
            if (isDragging && tt > size.width / 4) widget.callback();
            setState(() {
              isDragging = false;
              point = Offset(size.width, 0);
              start = Offset.zero;
            });
          },
          onHorizontalDragUpdate: (details) {
            if (size.width - start.dx > 30) return;
            if ((start.dy - details.localPosition.dy).abs() >
                size.height * 0.1) {
              setState(() {
                point = Offset(size.width, 0);
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
            foregroundPainter: BackEffect(point, widget.color),
            child: widget.child,
          ),
        ));
  }
}

class BackEffect extends CustomPainter {
  Offset dragPoint;
  Color color;

  BackEffect(this.dragPoint, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final dy = size.height / 5;
    final p0 = Offset(size.width, 0);
    final p3 = dragPoint;
    final p6 = Offset(size.width, size.height);
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
