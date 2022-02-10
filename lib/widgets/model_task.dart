import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? email;
  String? department;
  String? uid;
  UserModel({this.name, this.email, this.department, this.uid});
  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
        name: json["name"].toString(),
        email: json["email"].toString(),
        department: json["department"].toString(),
        uid: json['uid'].toString());
  }

  // Future<UserModel> getdata() async {
  //   final data = await FirebaseFirestore.instance
  //       .collection("employee")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   final data1 = data.data() as Map<String, dynamic>;

  //   return UserModel.fromjson(data1);
  // }
}
