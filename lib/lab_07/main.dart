import 'package:cp838_flutter_basic/lab_07/network.dart';
import 'package:cp838_flutter_basic/lab_07/Photo.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  final List<Photo> _Photos = <Photo>[];
  List<Photo> _PhotosDisplay = <Photo>[];
  Network network = Network();

  @override
  void initState() {
    super.initState();
    network.fetchPhoto().then((value) {
      setState(() {
        _Photos.addAll(value);
        _PhotosDisplay = _Photos;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch JSON And ListView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: const Text('Fetch JSON And ListView',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white
                )),
          ),
          body: FutureBuilder<List<dynamic>>(
            future: network.fetchPhoto(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(child:
                  ListView.builder(
                    itemCount: _PhotosDisplay.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      return index == 0 ? _search() : _listRenderer(index - 1);
                    })
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
        ),
      ),
    );
  }

  _listRenderer(int index) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.only(
                top: 32, bottom: 32, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    _PhotosDisplay[index].title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold
                    )
                ),
              Image.network(_PhotosDisplay[index].thumbnailUrl,),
              ],
            )
        )
    );
  }

  _search() {
    return Padding(
      padding: const EdgeInsets.all(19),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search....",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _PhotosDisplay = _Photos.where((Photo) {
              var title = Photo.title.toLowerCase();
              return title.contains(text);
            }).toList();
          });
        },
      ),
    );
  }
}
