import 'package:app2/model/usermodel.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProductProvider productProvider;
  late File? pickedimage;
  late PickedFile? image;
  Future<void> getImage() async {
    image = await ImagePicker().getImage(source: ImageSource.gallery);
    pickedimage = File(image!.path);
  }

  String? imageUrl;
  void _uploadImage({required File image}) async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("userImage/${user.uid}");
    UploadTask uploadTask = ref.putFile(image);
    imageUrl = await uploadTask.then((res) => res.ref.getDownloadURL());
  }

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
  Widget _buildSinglecontainerx() {
    List<UserModel> userModel = productProvider.getUserModelList;
    return Column(
        children: userModel.map((e) {
      return Column(children: [
        Column(
          children: [
            _buildSingleContainer(
                startText: "Name :", endText: "Aliphonza Nderitu"),
            _buildSingleContainer(startText: "Email :", endText: e.email),
            _buildSingleContainer(
                startText: "Phone number :", endText: e.phoneNo)
          ],
        ),
      ]);
    }).toList());
  }

  Widget _buildTextformFieldx() {
    List<UserModel> userModel = productProvider.getUserModelList;
    return Column(
        children: userModel.map((e) {
      return Column(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSingleTextFormField(name: "Aliphonza"),
            _buildSingleTextFormField(name: e.email),
            _buildSingleTextFormField(name: e.phoneNo)
          ],
        ),
      ]);
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    List<UserModel> userModel = productProvider.getUserModelList;
    productProvider.getUserdata();

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
                  onPressed: () {
                    _uploadImage(image: pickedimage!);
                    setState(() {
                      edit = false;
                    });
                  },
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
                        backgroundImage: pickedimage == null
                            ? AssetImage("lib/images/beetroot.jpg")
                                as ImageProvider
                            : FileImage(pickedimage!)),
                  ],
                ),
              ),
              edit == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 220, top: 100),
                      child: Card(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: (() {
                            getImage();
                          }),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
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
                    ? _buildTextformFieldx()
                    : _buildSinglecontainerx()),
          ],
        ),
      ),
    );
  }
}
