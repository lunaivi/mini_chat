import 'package:chat_minits/componet/my_button.dart';
import 'package:chat_minits/componet/my_textfield.dart';
import 'package:chat_minits/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

//Login method
  void login(BuildContext context) async {
//aut service

    final authService = AuthService();

//try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    }
//catch any erros
    catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: e.toString(),
      );
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text(e.toString()),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.message,
              size: 100,
            ),
            const SizedBox(height: 25),
            const Text(
              'Bienvenido',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 25),
            MyTextField(
              text: 'Email',
              controller: _emailController,
              icn: const Icon(
                Icons.email,
              ),
              obscuretext: false,
            ),
            const SizedBox(height: 25),
            MyTextField(
              text: 'Password',
              controller: _pwController,
              icn: const Icon(Icons.lock),
              obscuretext: true,
            ),
            const SizedBox(height: 25),
            My_button(
              texts: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'no te has ',
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    'registrado',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
