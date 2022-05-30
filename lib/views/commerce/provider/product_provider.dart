import 'dart:core';
import 'package:app2/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/cartmodel.dart';
import '../../../model/product.dart';

class ProductProvider with ChangeNotifier {
  UserModel? userModel;
  List<UserModel> userModelList = [];
  Future<void> getUserdata() async {
    List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser!;
    QuerySnapshot userDatasnapshot =
        await FirebaseFirestore.instance.collection('user').get();
    userDatasnapshot.docs.forEach(
      (element) {
        if (currentUser.uid == element.get("userId")) {
          userModel = UserModel(
            address: element.data().toString().contains('address')
                ? element["address"]
                : '',
            userImage: element.data().toString().contains('userImage')
                ? element["userImage"]
                : '',
            userName: element.data().toString().contains('userName')
                ? element["userName"]
                : '',
            email: element.data().toString().contains('email')
                ? element["email"]
                : '',
            phoneNo: element.data().toString().contains('phoneNo')
                ? element["phoneNo"]
                : '',
          );
          newList.add(userModel!);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  List<CartModel> cartModelList = [];
  late CartModel cartmodel;
  void getCartData({
    required String image,
    required String name,
    required int quantity,
    required int price,
  }) {
    cartmodel =
        CartModel(image: image, quantity: quantity, price: price, name: name);
    cartModelList.add(cartmodel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int get getCartModelListlength {
    return cartModelList.length;
  }

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

  void getCheckOutData({
    required int quantity,
    required int price,
    required String name,
    required String image,
  }) {
    checkOutModel = CartModel(
      price: price,
      name: name,
      image: image,
      quantity: quantity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  List<Product> feature = [];
  late Product featuredata;
  Future<void> getfeaturedata() async {
    List<Product> newlist = [];
    QuerySnapshot featuresnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc('rYQ1pht4E4JOxb8NZoJi')
        .collection('featureProducts')
        .get();
    featuresnapshot.docs.forEach((element) {
      featuredata = Product(
        image:
            element.data().toString().contains('image') ? element["image"] : '',
        name: element.data().toString().contains('name') ? element['name'] : '',
        price:
            element.data().toString().contains('price') ? element['price'] : 0,
      );
      newlist.add(featuredata);
    });

    feature = newlist;
    //notifyListeners();
  }

  List<Product> get getfeaturelist {
    return feature;
  }

  List<Product> homeFeature = [];
  late Product homeFeaturedata;
  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot homeFeaturesnapshot =
        await FirebaseFirestore.instance.collection('homefeature').get();
    homeFeaturesnapshot.docs.forEach((element) {
      homeFeaturedata = Product(
        image:
            element.data().toString().contains('image') ? element["image"] : '',
        name: element.data().toString().contains('name') ? element['name'] : '',
        price:
            element.data().toString().contains('price') ? element['price'] : 0,
      );
      newList.add(homeFeaturedata);
    });
    homeFeature = newList;
  }

  List<Product> get getHomeFeaturelist {
    return homeFeature;
  }

  List<Product> newarrival = [];
  late Product newarrivaldata;
  Future<void> getnewarrivaldata() async {
    List<Product> newlist = [];
    QuerySnapshot newarrivalssnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc('rYQ1pht4E4JOxb8NZoJi')
        .collection('newArrivals')
        .get();

    newarrivalssnapshot.docs.forEach((element) {
      newarrivaldata = Product(
        image:
            element.data().toString().contains('image') ? element["image"] : '',
        name: element.data().toString().contains('name') ? element['name'] : '',
        price:
            element.data().toString().contains('price') ? element['price'] : 0,
      );
      newlist.add(newarrivaldata);
    });
    newarrival = newlist;
    //notifyListeners();
  }

  List<Product> get getnewArrivallist {
    return newarrival;
  }

  List<Product> homeArrival = [];
  late Product homeArrivaldata;
  Future<void> gethomeArrivaldata() async {
    List<Product> newList = [];
    QuerySnapshot homeArrivalssnapshot =
        await FirebaseFirestore.instance.collection('homeArrivals').get();

    homeArrivalssnapshot.docs.forEach((element) {
      homeArrivaldata = Product(
        image:
            element.data().toString().contains('image') ? element['image'] : '',
        name: element.data().toString().contains('name') ? element['name'] : '',
        price:
            element.data().toString().contains('price') ? element['price'] : 0,
      );
      newList.add(homeArrivaldata);
    });
    homeArrival = newList;
  }

  List<Product> get homeArrivalRow {
    return homeArrival;
  }

  List<String> notificationList = [];
  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getnotificationsList {
    return notificationList.length;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  List<Product> searchList = [];
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchlist = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchlist;
  }
}
