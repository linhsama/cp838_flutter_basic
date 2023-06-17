import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/register.dart';
import '../component/button.dart';
import 'login.dart';

class WelCome extends StatefulWidget {
  const WelCome({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelCome> createState() => _WelComeState();
}

class _WelComeState extends State<WelCome> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;


  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blue, end: Colors.white)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('lib/images/logo.png'),
                    height: 80.0,
                  ),

                ),
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Agne',
                      color: Colors.black
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [TypewriterAnimatedText('Flash Chat')],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, Login.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, Register.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
