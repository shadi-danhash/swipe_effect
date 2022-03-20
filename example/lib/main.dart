import 'package:example/screens/first_exapmle.dart';
import 'package:example/screens/seconde_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "demo": (ctx) => const Demo(),
        "first": (ctx) => const FirstExample(),
        "second": (ctx) => const SecondExample(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "demo",
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Effect Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () => Navigator.of(context).pushNamed("first"),
              padding: const EdgeInsets.all(50),
              child: const Text(
                "Example 1",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.blueAccent.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              highlightColor: Colors.transparent,
              onPressed: () => Navigator.of(context).pushNamed("second"),
              padding: const EdgeInsets.all(50),
              child: const Text(
                "Example 2",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              splashColor: Colors.greenAccent.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}
