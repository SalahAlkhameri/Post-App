

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  String? id;
  String? image;
  String? name;
  String? gmail;
  String? password;
  String? phone;

  UserModel({
    this.id,
    this.image,
    this.name,
    this.gmail,
    this.password,
    this.phone,
  });



  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        id: document.id,
        name: data['name'],
        gmail: data['gmail'],
        password: data['password'],
        phone: data['phone'],
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'name':name,
      'gmail':gmail,
      'password':password,
      'phone':phone,
      'image':image,
  };
}

}