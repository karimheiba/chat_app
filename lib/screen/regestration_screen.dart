import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/welcom_screen.dart';
import 'package:chat_app/widget/build_text_feild.dart';
import 'package:chat_app/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String screenRoute = "regester_screen";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            const SizedBox(
              height: 60,
            ),
            BuildTextField(
                onchange: (value) {
                  email = value;
                },
                hinttext: "Enter your Email"),
            const SizedBox(
              height: 25,
            ),
            BuildTextField(
                obscure: true,
                onchange: (value) {
                  password = value;
                },
                hinttext: "Enter your password"),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              color: Colors.blue,
              titel: "Register",
              onpressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.screenRoute);
                } catch (e) {
                  print(e);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Aleady have an acoount"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, WelcomScreen.screenRoute, (route) => false);
                    },
                    child: Text(
                      "clich here ?",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
