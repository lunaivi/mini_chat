import 'package:flutter/material.dart';

class My_button extends StatelessWidget {
  final String texts;
  const My_button({super.key, this.onTap, required this.texts});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 320,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 40, 40, 40)),
        child: Center(
            child: Text(
          texts,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
