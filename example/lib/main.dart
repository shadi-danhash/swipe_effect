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
        "second": (ctx) => const MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    return SwipeEffect(
      color: Colors.cyanAccent.withAlpha(50),
      callback: () { 
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'second');
          },
          child: const Icon(Icons.arrow_forward_rounded),
        ),
      ),
    );
  }
}
