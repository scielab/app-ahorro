import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final String? photo;

  UserModel({required this.name, required this.email, required this.uid,this.photo});

  Map<String,dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'photo': photo
    };
  }
  
  factory UserModel.fromQueryFirebase(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic> json = snapshot.data();
    return UserModel.fromJson(json);
  }

  factory UserModel.fromJson(Map<String,dynamic> map) {
    return UserModel(
      name: map['name'], 
      email: map['email'], 
      uid: map['uid'],
      photo: map['photo'] ?? '',
    );
  }

}