import 'package:chat_app/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String screenRoute = "chat_screen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser();
  }

  final _auth = FirebaseAuth.instance;

  void getuser() {
    try {
      final User = _auth.currentUser;
      if (User != null) {
        signInUser = User;
        throw signInUser.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  // void messageStreams() async {
  //   await for (var snapshot in _firestore.collection("messages").snapshots()) {
  //     for (var messege in snapshot.docs) {
  //       print(messege.data());
  //     }
  //   }
  // }

  // void getmessages() async {
  //   final messages = await _firestore.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }

  String? messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(context),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessageStreamBuilder(),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.blueAccent,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _textfield(),
                ),
                _SendButton(),
              ],
            ),
          ),
        ],
      )),
    );
  }

  IconButton _SendButton() {
    return IconButton(
      onPressed: () {
        messageTextController.clear();
        _firestore.collection("messages").add({
          "text": messageText,
          "sender": signInUser.email,
          "time": FieldValue.serverTimestamp(),
        });
      },
      icon: Icon(
        Icons.send,
        color: Colors.blueAccent,
      ),
    );
  }

  TextField _textfield() {
    return TextField(
      controller: messageTextController,
      onChanged: (value) {
        messageText = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          hintText: "Write your massege",
          border: InputBorder.none),
    );
  }

  AppBar _AppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: Row(
        children: [
          Image.asset(
            "asset/image/chat.png",
            height: 20,
          ),
          SizedBox(
            width: 15,
          ),
          Text("Live Chat")
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              // messageStreams();
            },
            icon: Icon(Icons.abc_outlined)),
        IconButton(
          onPressed: () {
            _auth.signOut().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                    context,
                    SignInScreen.screenRoute,
                    (route) => false,
                  ),
                );
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }
}

//chat stream builder

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy("time").snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.amber),
            );
          }

          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get("text");
            final messageSender = message.get("sender");
            final currentUser = signInUser.email;

            final messageWidgit = MessageLine(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageWidgit);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}

// chat text design

class MessageLine extends StatelessWidget {
  const MessageLine({this.sender, this.text, required this.isMe});

  final String? sender, text;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "$text",
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
