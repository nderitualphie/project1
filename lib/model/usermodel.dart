import 'package:flutter/material.dart';

class UserModel {
  String? userName;
  String? email;
  String? phoneNo;
  String? userImage;
  String? address;
  UserModel(
      {required this.email,
      required this.address,
      required this.phoneNo,
      required this.userImage,
      required this.userName});
}
