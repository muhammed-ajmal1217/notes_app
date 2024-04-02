
import 'package:flutter/material.dart';
import 'package:notesapp_task/controller/login_provider.dart';
import 'package:notesapp_task/views/login.dart';
import 'package:notesapp_task/views/sign_up_page.dart';
import 'package:provider/provider.dart';


class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.showLogin) {
      return LoginPage(
        showSignUp: loginProvider.toggleScreen,
      );
    } else {
      return SignUpPage(
        showLogin: loginProvider.toggleScreen,
      );
    }
  }
}