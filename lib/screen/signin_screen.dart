import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/widget/build_text_feild.dart';
import 'package:chat_app/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String screenRoute = "signin_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              child: Image.asset("asset/image/chat.png"),
            ),
            SizedBox(
              height: 60,
            ),
            BuildTextField(
                onchange: (value) {
                  email = value;
                },
                hinttext: "Enter your Email"),
            SizedBox(
              height: 25,
            ),
            BuildTextField(
                obscure: true,
                onchange: (value) {
                  password = value;
                },
                hinttext: "Enter your password"),
            SizedBox(
              height: 25,
            ),
            MyButton(
                color: Colors.blue,
                titel: "Sign in",
                onpressed: () async {
                  try {
                    final User = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (User != null) {
                      Navigator.pushNamed(context, ChatScreen.screenRoute);
                    }
                  } catch (e) {
                    throw e;
                  }
                })
          ],
        ),
      ),
    );
  }
}
