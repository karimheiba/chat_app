import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {required this.color, required this.titel, required this.onpressed});

  final Color color;
  final String titel;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 6,
        color: color,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          onPressed: onpressed,
          child: Text(
            titel,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          minWidth: 200,
          height: 40,
        ),
      ),
    );
  }
}
