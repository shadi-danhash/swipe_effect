import 'package:flutter/material.dart';
import 'package:swipe_effect/swipe_effect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "demo": (ctx) => const MyHomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo Swipe Effect'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = ""}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          ? Colors.red.withAlpha(50)
          : Colors.green.withAlpha(50),
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
                color: Colors.blue,
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
