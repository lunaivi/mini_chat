import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  // final TextEditingController pw_editingController;
  final Icon? icn;
  final String text;
  final bool obscuretext;
  final FocusNode? focusNade;
  const MyTextField({
    super.key,
    required this.text,
    required this.controller,
    // required this.pw_editingController,
    this.icn,
    required this.obscuretext,
    this.focusNade,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0),
      child: TextField(
        obscureText: obscuretext,
        focusNode: focusNade,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          icon: icn,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
