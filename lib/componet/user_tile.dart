import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;

  final void Function()? onTap;
  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //icon
            Icon(Icons.person),
            const SizedBox(width: 25),
            //user  name

            Text(text),
          ],
        ),
      ),
    );
  }
}
