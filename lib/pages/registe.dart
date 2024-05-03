import 'package:chat_minits/componet/my_button.dart';
import 'package:chat_minits/componet/my_textfield.dart';
import 'package:chat_minits/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class RegistePage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  final void Function()? onTap;
  RegistePage({super.key, required this.onTap});
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _pwController.text);
      } catch (e) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: e.toString(),
        );
      }
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: "Passwords don t' match!",
      );
    }
  }

  @override
  // final TextEditingController _emailditingController;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.message_outlined,
                size: 100,
              ),
              const SizedBox(height: 10),
              const Text('Registro', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              MyTextField(
                text: 'Email',
                controller: _emailController,
                icn: const Icon(Icons.email),
                obscuretext: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                text: 'Password',
                controller: _pwController,
                icn: const Icon(Icons.lock),
                obscuretext: true,
              ),
              const SizedBox(height: 15),
              MyTextField(
                text: 'Confirm',
                controller: _confirmPwController,
                icn: const Icon(Icons.lock),
                obscuretext: true,
              ),
              const SizedBox(height: 15),
              My_button(
                texts: 'Register',
                onTap: () => register(context),
              ),
              const SizedBox(height: 15),
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
                      'Login',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
