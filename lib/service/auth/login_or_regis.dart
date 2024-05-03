import 'package:chat_minits/pages/login_page.dart';
import 'package:chat_minits/pages/registe.dart';
import 'package:flutter/material.dart';

class Login_or_Registe extends StatefulWidget {
  const Login_or_Registe({super.key});

  @override
  State<Login_or_Registe> createState() => _Login_or_RegisteState();
}

class _Login_or_RegisteState extends State<Login_or_Registe> {
  bool showLoginPage = true;

  void togglePages() {
    // TODO: implement setState
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegistePage(onTap: togglePages);
    }
  }
}
