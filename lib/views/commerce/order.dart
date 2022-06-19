import 'package:app2/views/commerce/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Orderpage extends StatelessWidget {
  const Orderpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Order"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(children: [
              Text(
                "Kindly bear with us as we process your order, We will contact you within the next one hour to convey details. Thank you for shopping with us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.all(10),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => DefaultPage()));
              },
              icon: Icon(Icons.home),
              label: Text("Back Home"),
            )
          ],
        ),
      ),
    );
  }
}
