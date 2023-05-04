import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpinWheel(),
    );
  }
}

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<StatefulWidget> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();

  List<int> items = [100, 200, 300];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: FortuneWheel(
              selected: selected.stream,
              animateFirst: false,
              items: [
                for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                  FortuneItem(
                    child: Text(items[i].toString()),
                  ),
                }
              ],
            ),
          )
        ],
      ),
    ));
  }
}