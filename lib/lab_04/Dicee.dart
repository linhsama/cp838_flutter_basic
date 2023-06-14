import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dicee(),
    );
  }
}

class Dicee extends StatefulWidget {
  const Dicee({super.key});

  @override
  State<Dicee> createState() => _DiceeState();
}

class _DiceeState extends State<Dicee> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  void changeDiceFace() {
    setState(() {
      leftDiceNumber = Random().nextInt(6)+1;
      rightDiceNumber = Random().nextInt(6)+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dicee'),
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(child: TextButton(child: Image.asset('lib/images/dice${leftDiceNumber}.png'),onPressed: () {
              changeDiceFace();
            },)),
            Expanded(child: TextButton(child: Image.asset('lib/images/dice${rightDiceNumber}.png'),onPressed: () {
              changeDiceFace();
            },)),
          ],
        ),
      )
    );
  }
}

