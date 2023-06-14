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
      title: 'Mi card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mi card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/images/logo.png'),
            ),
            const Text('Lê Vũ Linh', style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              ),
            ),

            const Text('flutter course',
              style: TextStyle(color: Colors.white70, fontFamily: 'Source Sans Pro', fontSize: 20),
            ),

            const SizedBox(
              height: 50,
              child: VerticalDivider(
                thickness: 3,
                width: 4,
                indent: 0,
                color: Colors.white,
              ),
            ),

            Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.blueGrey,),
                title: Text('+84 0947 8xx 8xx',
                  style: TextStyle(color: Colors.teal.shade900, fontFamily: 'Source Sans Pro', fontSize: 20),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blueGrey,),
                title: Text('itlvlinh@gmail.com',
                  style: TextStyle(color: Colors.teal.shade900, fontFamily: 'Source Sans Pro', fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
