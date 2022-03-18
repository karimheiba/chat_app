import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/home_page.dart';
import 'package:chat_app/screen/regestration_screen.dart';
import 'package:chat_app/screen/signin_screen.dart';
import 'package:chat_app/screen/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _aut = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home: ChatScreen(),
        initialRoute: _aut.currentUser != null
            ? ChatScreen.screenRoute
            : WelcomScreen.screenRoute,
        routes: {
          WelcomScreen.screenRoute: (context) => const WelcomScreen(),
          RegistrationScreen.screenRoute: (context) =>
              const RegistrationScreen(),
          SignInScreen.screenRoute: (context) => const SignInScreen(),
          ChatScreen.screenRoute: (context) => const ChatScreen(),
          HomePage.screenRoute: (context) => const HomePage(),
        });
  }
}
