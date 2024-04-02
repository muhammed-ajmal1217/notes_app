import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String? id;
  String? email;
  String? userName;
  UserModel({
    this.id,
    this.email,
    this.userName,
  });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
      id: json['id'],
      email: json['email'],
      userName: json['user_name'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'email':email,
      'user_name':userName,
    };
  }
}
