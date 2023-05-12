import 'package:flutter/material.dart';

import 'Screen1.dart';
import 'Screen2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String id = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.transparent, onSurface: Colors.transparent, shadowColor: Colors.transparent),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Screen1()));},
                    child: const Padding(padding: EdgeInsets.only(top: 18, bottom: 18), child: Text("Push"),),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.transparent, onSurface: Colors.transparent, shadowColor: Colors.transparent),
                    onPressed: (){Navigator.pushNamed(context, Screen2.id);},
                    child: const Padding(padding: EdgeInsets.only(top: 18, bottom: 18), child: Text("Pushnamed")),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

