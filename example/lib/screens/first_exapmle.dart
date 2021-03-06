import 'package:flutter/material.dart';
import 'package:swipe_effect/swipe_effect.dart';

class FirstExample extends StatefulWidget {
  const FirstExample({Key? key, this.title = "First Example"})
      : super(key: key);

  final String title;

  @override
  State<FirstExample> createState() => _FirstExampleState();
}

class _FirstExampleState extends State<FirstExample> {
  TextDirection direction = TextDirection.rtl;
  double start = 30;
  double callbackDelta = 0.25;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SwipeEffect(
      direction: direction,
      color: direction == TextDirection.rtl
          ? Colors.red.withAlpha(70)
          : Colors.green.withAlpha(70),
      verticalTolerance: 1.0,
      startDeltaPx: start,
      callbackDeltaRatio: callbackDelta,
      callback: () {
        setState(() {
          start += 10;
          callbackDelta += 0.1;
        });
        // Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              direction = direction == TextDirection.rtl
                  ? TextDirection.ltr
                  : TextDirection.rtl;
              callbackDelta = 0.25;
              start = 30;
            });
          },
          child: const Icon(Icons.swap_horiz),
        ),
        body: Stack(
          children: [
            Align(
              alignment: direction == TextDirection.ltr
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                color: Colors.blue.withOpacity(0.5),
                width: start,
              ),
            ),
            Align(
              alignment: direction == TextDirection.ltr
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                color: Colors.black.withAlpha(30),
                width: callbackDelta * size.width,
              ),
            ),
            Center(
              child: Text(
                direction == TextDirection.rtl ? 'Swipe left' : "Swipe right",
                style: TextStyle(
                  color: direction == TextDirection.rtl
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
