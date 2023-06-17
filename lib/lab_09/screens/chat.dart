import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../contrast.dart';
import 'dart:io';


final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class Chat extends StatefulWidget {
  static const String id = 'chat';

  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print('Đây là thông tin user: $user');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat '),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        imageUrl = null;
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'timestamp': DateTime.now(),
                          'url': imageUrl
                        });

                      },
                      child: const Icon(Icons.send)),
                  IconButton(
                      onPressed: uploadImage, icon: const Icon(Icons.image)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage() async {
    final imagePicker = ImagePicker();
    PickedFile? image;
    // UploadTask uploadTask;
    //Check Permissions
    var permission = Platform.isAndroid
        ? Permission.storage
        : Permission.photos;

    var permissionStatus = await permission.request();
    //
    // await Permission.photos.request();
    //
    // var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('images/${image.path.split('/').last}')
            .putFile(file)
            .whenComplete(() => {});
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print('Link: $downloadUrl');
        setState(() {
          imageUrl = downloadUrl;
        });
        _firestore.collection('messages').add({
          'text': '',
          'sender': loggedInUser.email,
          'timestamp': DateTime.now(),
          'url': imageUrl
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageImage = message.get('url');
          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
            url: messageImage,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, this.sender, this.text, this.isMe, this.url});
  final String? sender;
  final String? text;
  final bool? isMe;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender!,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          url == null
              ? Row(
                  mainAxisAlignment:
                      isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: isMe!
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                      elevation: 5.0,
                      color: isMe! ? Colors.blue : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          text!,
                          style: TextStyle(
                            color: isMe! ? Colors.white : Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Image.network(url!),
        ],
      ),
    );
  }
}
