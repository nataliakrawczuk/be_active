import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  String rewards = '';

  List<String> items = [
    'Go jogging',
    'Practice meditation',
    'Go to the gym',
    'Go for a walk',
    'Take a hike',
    'Go for a bike ride',
    'Do stretching'
  ];

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 380,
              width: 380,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: items
                    .map(
                      (item) => FortuneItem(
                        child: Text(item.toString()),
                      ),
                    )
                    .toList(),
                onAnimationEnd: () {
                  setState(() {
                    rewards = rewards = items[selected.value];
                  });

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Congratulation!'),
                        content: Text('Now stand up and $rewards!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected.add(Fortune.randomInt(0, items.length));
                });
              },
              child: Container(
                height: 50,
                width: 150,
                color: Colors.greenAccent,
                child: Text('SPIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
