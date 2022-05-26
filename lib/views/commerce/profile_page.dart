import 'package:app2/views/commerce/notifications.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildSingleTextFormField({required String name}) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              endText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55,
        width: 80,
        margin: const EdgeInsets.all(10),
        child: edit == false
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    edit = true;
                  });
                },
                child: const Text(
                  'Edit profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
              )
            : Container(),
      ),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ))
            : Container(),
        backgroundColor: Colors.green,
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(children: [
              Container(
                height: 160,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      maxRadius: 80,
                      backgroundImage: AssetImage("lib/images/beetroot.jpg"),
                    ),
                  ],
                ),
              ),
              edit == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 220, top: 100),
                      child: Card(
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
            Container(
                height: 300,
                width: double.infinity,
                child: edit == true
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSingleTextFormField(name: "Aliphonza Nderitu"),
                          _buildSingleTextFormField(
                              name: "aliphonzanderitu@gmail.com"),
                          _buildSingleTextFormField(name: "0791784445")
                        ],
                      )
                    : Column(children: [
                        Column(
                          children: [
                            _buildSingleContainer(
                                startText: "Name :",
                                endText: "Aliphonza Nderitu"),
                            _buildSingleContainer(
                                startText: "Email :",
                                endText: "aliphonzanderitu@gmail.com"),
                            _buildSingleContainer(
                                startText: "Phone number :",
                                endText: "0791784445")
                          ],
                        ),
                      ])),
          ],
        ),
      ),
    );
  }
}
