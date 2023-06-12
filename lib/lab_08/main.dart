import 'package:flutter/material.dart';

import 'contact.dart';
import 'dbhelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SQLite CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _fromKey = GlobalKey<FormState>();
  late  Contact _contact = Contact();
  List<Contact> _contacts = [];
  DBHelper? _dbHelper;
  final _ctrlName = TextEditingController();
  final _ctrlMobile = TextEditingController();
  @override
  void initState(){
    super.initState();
    setState((){
      _dbHelper = DBHelper();
    });
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _form(),
            _list()
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  _form() => Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _fromKey,
      child: Column(
        children: [
          TextFormField(
            controller: _ctrlName,
            decoration: const InputDecoration(
                labelText: 'Tên'
            ),
            onSaved: (val){
              setState(() {
                _contact.name = val;
              });
            },
            validator: (val) =>
            ((val?.length ?? 0)  == 0? 'Tên không được để trống':null),
          ),
          TextFormField(
            controller: _ctrlMobile,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                labelText: 'Số điện thoại'
            ),
            onSaved: (val){
              setState(() {
                _contact.mobile = val;
              });
            },
            validator: (val) =>
            ((val?.length ?? 0)  < 10 ? 'Số điện thoại phải lớn hơn 10 số':null),


          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Lưu'),

            ),
          )
        ],
      ),
    ),
  );
  _onSubmit() async {
    var form = _fromKey.currentState;
    if(_fromKey.currentState!.validate()){
      form?.save();
      if(_contact.id == null){
        await _dbHelper!.insertContact(_contact);
      }
      else {
        await _dbHelper!.updateContact(_contact);
      }
      _refreshData();
      _resetData();
    }
    else {
      print('Form check false:');
    }

  }
  _refreshData() async {
    List<Contact> x = await _dbHelper!.fecthContact();
    setState((){
      _contacts = x;
    });
  }
  _resetData(){
    setState((){
      _fromKey.currentState?.reset();
      _ctrlName.clear();
      _ctrlMobile.clear();
      _contact.id = null;
    });
  }


  _list() =>Expanded(
    child: Card (
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.account_circle, color: Colors.cyan,),
                    title: Text(_contacts[index].name!.toUpperCase()),
                    subtitle: Text(_contacts[index].mobile!),
                    onTap: (){
                      setState((){
                        _contact = _contacts[index];
                        _ctrlName.text = _contacts[index].name!;
                        _ctrlMobile.text = _contacts[index].mobile!;
                      });
                    },
                    trailing: IconButton(
                        onPressed: () async {
                          await _dbHelper?.deleteContact(_contacts[index].id!);
                          _resetData();
                          _refreshData();
                        },
                        icon: const Icon(Icons.delete_sweep, color: Colors.cyan,))

                ),
                const Divider(
                  height: 5.0,
                ),



              ],
            );
          },
          itemCount: _contacts.length,
        )),
  );

}