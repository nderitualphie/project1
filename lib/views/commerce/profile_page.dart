import 'dart:io';

import 'package:app2/views/commerce/homepage.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/usermodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel userModel;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController userName;
  late TextEditingController email;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);

  // void vaildation() async {
  //   if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("All Fields Are Empty"),
  //       ),
  //     );
  //   } else if (userName.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Name Is Empty "),
  //       ),
  //     );
  //   } else {
  //     userDetailUpdate();
  //   }
  // }

  File? _pickedImage;

  PickedFile? _image;
  Future<void> getImage({required ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image!.path);
      });
    }
  }

  String? userUid;

  Future<String> _uploadImage({required File image}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child("userImage/$userUid");
    UploadTask uploadTask = storageReference.putFile(image);

    String imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser!;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;
  Future<void> userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage!)
        : Container();
    FirebaseFirestore.instance.collection("user").doc(userUid).update({
      "userName": userName.text,
      "phoneNo": phoneNumber.text,
      "UserImage": imageMap,
      "address": address.text,
      "email": email.text,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = true;
    });
  }

  Widget _buildSingleContainer(
      {required String startText, required String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  late String userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    address = TextEditingController(text: userModel.address);
    userName = TextEditingController(text: userModel.userName);
    phoneNumber = TextEditingController(text: userModel.phoneNo);
    email = TextEditingController(text: userModel.email);

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: userModel.userName!,
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: userModel.email!,
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: userModel.phoneNo!,
            startText: "Phone Number",
          ),
          _buildSingleContainer(
            endText: userModel.address!,
            startText: "Address",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Pick From Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text("Pick From Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFieldPart() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: userName,
            decoration: InputDecoration(
                hintText: "User name", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
                hintText: "Email", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: address,
            decoration: InputDecoration(
                hintText: "Address", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: phoneNumber,
            decoration: InputDecoration(
                hintText: "Phone Number ", border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => DefaultPage(),
                      ),
                    );
                  });
                },
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.greenAccent,
                  ),
                  onPressed: () {
                    userDetailUpdate();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var myDoc = (snapshot.data as QuerySnapshot).docs;
                      myDoc.forEach((checkDocs) {
                        if (checkDocs.get("userId") == userUid) {
                          userModel = UserModel(
                            email: checkDocs.data().toString().contains('email')
                                ? checkDocs["email"]
                                : "",
                            userImage: checkDocs
                                    .data()
                                    .toString()
                                    .contains('UserImage')
                                ? checkDocs["UserImage"]
                                : '',
                            address:
                                checkDocs.data().toString().contains('address')
                                    ? checkDocs["address"]
                                    : '',
                            userName:
                                checkDocs.data().toString().contains('userName')
                                    ? checkDocs["userName"]
                                    : '',
                            phoneNo:
                                checkDocs.data().toString().contains('phoneNo')
                                    ? checkDocs["phoneNo"]
                                    : '',
                          );
                        }
                      });
                      return Container(
                        height: 600,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 180,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          maxRadius: 65,
                                          backgroundImage: _pickedImage == null
                                              ? userModel.userImage == null
                                                  ? AssetImage(
                                                          "lib/images/beetroot.png")
                                                      as ImageProvider
                                                  : NetworkImage(
                                                      userModel.userImage!)
                                              : FileImage(_pickedImage!)),
                                    ],
                                  ),
                                ),
                                edit == true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                220,
                                            top: MediaQuery.of(context)
                                                    .viewPadding
                                                    .left +
                                                110),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              myDialogBox(context);
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.greenAccent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Container(
                              height: 350,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: edit == true
                                          ? _buildTextFormFieldPart()
                                          : _buildContainerPart(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20)),
                                child: edit == false
                                    ? ElevatedButton(
                                        child: Text("Edit Profile"),
                                        onPressed: () {
                                          setState(() {
                                            edit = true;
                                          });
                                        },
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
