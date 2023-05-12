import 'dart:async';

import 'package:cp838_flutter_basic/lab_02/profile.dart';
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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () => Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
        return const Profile();},),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Splash Screen", style: TextStyle(color: Colors.white, fontSize:40))],
            ),
          )
        ),
    );
  }
}

