import 'package:flutter/material.dart';

import 'homepage.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => DefaultPage()));
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          width: double.infinity,
          child: Text(
            "© 2022 AgroCommerce ™",
            textAlign: TextAlign.center,
          ),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => DefaultPage()));
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Image(
                image: AssetImage("lib/images/farmer.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 360,
                child: Wrap(
                  children: const [
                    Text(
                      "Agriculture commerce is aimed at making the process of selling and purchasing agricultural produce easy for both the farmer and the purchaser. We source fresh produce to ease your hustle and have them delivered to your doorstep.",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
