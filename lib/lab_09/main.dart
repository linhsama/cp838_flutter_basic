import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/chat.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatFirebase());
}

class ChatFirebase extends StatelessWidget {
  const ChatFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelCome.id,
      routes: {
        WelCome.id: (context) => const WelCome(),
        Login.id: (context) => const Login(),
        Register.id: (context) => const Register(),
        Chat.id: (context) => const Chat(),
      },
    );
  }
}
