import 'package:flutter/material.dart';
import 'package:swipe_effect/swipe_effect.dart';

class SecondExample extends StatefulWidget {
  const SecondExample({Key? key, this.title = "Second Example"})
      : super(key: key);

  final String title;

  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  TextDirection direction = TextDirection.rtl;
  double start = 30;
  double callbackDelta = 0.25;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeEffect(
      direction: direction,
      color: Colors.cyanAccent.withAlpha(70),
      verticalTolerance: 1.0,
      startDeltaPx: start,
      callbackDeltaRatio: callbackDelta,
      callback: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("second");
          },
          child: const Icon(Icons.add),
          tooltip: "push new page",
        ),
        body: Center(
          child: Text(
            "Swipe to the right to go back\n\nOR\n\nClick on the + icon to push new page",
            style: TextStyle(
                color: Colors.tealAccent.shade400,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
