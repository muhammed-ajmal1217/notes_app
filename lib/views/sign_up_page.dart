import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp_task/main_widgets/text_field.dart';
import 'package:notesapp_task/main_widgets/toggle_screen.dart';
import 'package:notesapp_task/service/auth_service.dart';

class SignUpPage extends StatefulWidget {
  VoidCallback showLogin;
   SignUpPage({super.key,required this.showLogin});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  Color white = Colors.white;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130,),
            Text(
              'Sign up',
              style: GoogleFonts.raleway(
                  color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text('Please fill out the following required fields',style: GoogleFonts.raleway(color: white),),
            TextFieldWidget(hintText: 'Name', controller: nameController),
            // TextFieldWidget(hintText: 'E-mail', controller: emailController),
            Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: emailController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: 'E-mail',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),

            TextFieldWidget(
                hintText: 'Password', controller: passwordController),
            TextFieldWidget(
                hintText: 'Confirm password', controller: confirmController),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    signUp();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                      child: Center(child: Text('Sign up',style:GoogleFonts.raleway(color: white,fontSize: 20,fontWeight: FontWeight.w500),)),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                ToggleScreen(
                  screenHeight: height,
                  screenWidth: width,
                  toggleScreen: () => widget.showLogin(),
                  text1: 'login with an existing account',
                  text2: 'Login',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  signUp(){
        if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Not Match')));
    }
    AuthService().signUpWithEmail(
        email: emailController.text.trim(),pass: passwordController.text.trim(),name: nameController.text.trim());
  }
  }