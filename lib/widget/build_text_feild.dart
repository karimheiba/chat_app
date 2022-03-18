import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({required this.hinttext, this.onchange, this.obscure = false});
  final String hinttext;
  final Function(String)? onchange;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      textAlign: TextAlign.center,
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 49, 136, 207),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 59, 151, 226),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
