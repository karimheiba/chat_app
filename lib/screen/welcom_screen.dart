import 'package:chat_app/screen/regestration_screen.dart';
import 'package:chat_app/screen/signin_screen.dart';
import 'package:chat_app/widget/my_button.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({Key? key}) : super(key: key);
  static const String screenRoute = "welcome_screen";

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  child: Image.asset("asset/image/chat.png"),
                ),
                Text("Live Chat",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        color: Colors.lightBlue[400])),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            MyButton(
              color: Colors.lightBlue[700]!,
              titel: "Sign in",
              onpressed: () {
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            MyButton(
              color: Colors.lightBlue[700]!,
              titel: "Register",
              onpressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
