import 'dart:core';

import 'package:app2/views/commerce/homepage.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/usermodel.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController message = TextEditingController();
  String? name;
  String? email;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void vaildation() async {
    if (message.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Fill The Message"),
        ),
      );
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection("Message").doc(user!.uid).set({
        "Name": name,
        "Email": email,
        "Message": message.text,
      });
    }
  }

  Widget _buildSingleField({required String name}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.green),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    ProductProvider provider;
    provider = Provider.of<ProductProvider>(context, listen: false);
    List<UserModel> user = provider.userModelList;
    user.map((e) {
      name = e.userName;
      email = e.email;

      return Container();
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    // return WillPopScope(
    //   onWillPop: () async {
    //     return await Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (ctx) => DefaultPage()));
    //   },
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        title: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => DefaultPage()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 27),
        height: 500,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Send Us Your Message",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
              ),
            ),
            _buildSingleField(name: name!),
            _buildSingleField(name: email!),
            Container(
              height: 200,
              child: TextFormField(
                controller: message,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: " Message",
                ),
              ),
            ),
            ElevatedButton(
               style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.all(10),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
              child: Text("Submit"),
              onPressed: () {
                vaildation();
              },
            )
          ],
        ),
      ),
    );
  }
}
