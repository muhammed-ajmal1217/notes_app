import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp_task/main_widgets/text_field.dart';
import 'package:notesapp_task/main_widgets/toggle_screen.dart';
import 'package:notesapp_task/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  VoidCallback showSignUp;
   LoginPage({super.key,required this.showSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color white= Colors.white;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline,color: Colors.white,size: 50,),
          Text('Login',
              style: GoogleFonts.raleway(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          Text('Please Enter the E-mail and password',style: GoogleFonts.raleway(color: white),),
          TextFieldWidget(controller: emailController, hintText: 'E-mail'),
          TextFieldWidget(
              controller: passwordController, hintText: 'Password'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: login,
                
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber,
                    ),
                    child: Center(child: Text('Login',style:GoogleFonts.raleway(color: white,fontSize: 20,fontWeight: FontWeight.w500),)),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              ToggleScreen(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                text1: 'Create New Account',
                text2: 'Sign up',
                toggleScreen: () => widget.showSignUp(),
              ),
            ],
          ),
        ],
      ),
    );
  }
login()async{
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  if(email.isNotEmpty&&password.isNotEmpty){
    await AuthService().signInWithEmail(email, password, context);
  }else{
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email or Password is Empty')));
  }
}
}

