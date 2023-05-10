import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info basic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Info basic'),
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
          children: [
            name,
            age,
            address,
            gpa,
          ],
        )
      ),
    );
  }
}
final name = Container(
  margin: const EdgeInsets.all(10),
  alignment: Alignment.centerLeft,
  child: const Text('Tên: Nguyễn Văn A',
    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
    softWrap: true,
  ),
);


final age = Container(
  margin: const EdgeInsets.all(10),
  alignment: Alignment.centerLeft,
  child: const Text('Sinh năm: 2000',
    style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w400),
    softWrap: true,
  ),
);


final address = Container(
  margin: const EdgeInsets.all(10),
  alignment: Alignment.centerLeft,
  child: const Text('Quê quán: Ấp, Xã/ Phường, Quận/Huyện, Tỉnh.Thành phố',
    softWrap: true,
    style: TextStyle(fontSize: 26, color: Colors.red, fontWeight: FontWeight.bold),),
);


final gpa = Container(
  margin: const EdgeInsets.all(10),
  alignment: Alignment.topRight,
  child: const Text('Điểm GPA: 2.53',
    softWrap: true,
    style: TextStyle(fontSize: 32, color: Colors.yellow, fontWeight: FontWeight.bold, fontFamily: 'Pacifico', fontStyle: FontStyle.italic),),
);
