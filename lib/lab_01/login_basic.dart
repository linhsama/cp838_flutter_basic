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
      title: 'Login',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
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

  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _username,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: '',
              labelText: 'Username',
            ),
            // onChanged: (value) {
            //    setState(() {
            //      _username = value.toString();
            //    });
            // },
            validator: (value) {
              return (value == null  || value.isEmpty ? 'Username is required' : null);
            },
          ),

          TextFormField(
            obscureText: true,
            controller: _password,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: '',
              labelText: 'Password',
            ),
            // onChanged: (value) {
            //     setState(() {
            //       _password = value.toString();
            //     });
            // },
            validator: (value) {
              return (value == null  || value.isEmpty ? 'Password is required' : null);
            },
          ),


          Container(
            margin: const EdgeInsets.all(20),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("_username: " + _username.text + "\n _password: " + _password.text)),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

