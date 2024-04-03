import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp_task/model/user_model.dart';

class AuthService{
  FirebaseAuth auth =FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
    Future<UserCredential?> signInWithEmail(
      String email, String pass, context) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } on FirebaseAuthException catch (e) {
      String errorcode = "error singIn";
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        errorcode = "Icorrect email or password";
      } else if (e.code == 'user-disabled') {
        errorcode = "User not found";
      } else {
        errorcode = e.code;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorcode)));
      return null;
    }
  }

  Future<UserCredential> signUpWithEmail(
   { String? email,
    String? pass,
    String? name,}
  ) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email!, password: pass!);
      final UserModel userdata =
          UserModel(email: email, userName: name, id: user.user!.uid);

      firestore.collection('users').doc(user.user!.uid).set(userdata.toJson());
      print(email);
      print(name);
      print(user.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  
  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      //Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out')),
      );
    }
  }
}