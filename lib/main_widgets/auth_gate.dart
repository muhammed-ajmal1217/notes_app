import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp_task/main_widgets/toggle_auth.dart';
import 'package:notesapp_task/main_widgets/toggle_screen.dart';
import 'package:notesapp_task/views/home.dart';

class AuthGatePage extends StatefulWidget {
  @override
  State<AuthGatePage> createState() => _AuthGatePageState();
}

class _AuthGatePageState extends State<AuthGatePage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus(); 
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? HomePage() : ToggleAuth();
  }

  void checkLoggedInStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
      });
      // Delay the navigation until after the build is complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }
  }
}
