import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/cartmodel.dart';
import '../../../model/product.dart';

class ProductProvider with ChangeNotifier {
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
 void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData({
    int? quantity,
    int? price,
    String? name,
    
    String? image,
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
}
