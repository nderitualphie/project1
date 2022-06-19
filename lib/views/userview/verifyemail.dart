import 'dart:async';
import 'package:app2/views/commerce/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verifyemailpage extends StatefulWidget {
  const Verifyemailpage({Key? key}) : super(key: key);

  @override
  State<Verifyemailpage> createState() => _VerifyemailpageState();
}

class _VerifyemailpageState extends State<Verifyemailpage> {
  bool isEmailVerified = false;
  bool canresendemail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 5), (_) => checkEmailVerified);
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  void sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canresendemail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canresendemail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? DefaultPage()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Verify Email"),
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "A verification email has been sent to you",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    sendVerificationEmail();
                  },
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    "resend email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
            ]),
          ),
        );
}
