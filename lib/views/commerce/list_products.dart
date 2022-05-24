import 'package:app2/views/commerce/detail_page.dart';
import 'package:app2/views/commerce/singleproducts.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';
import 'homepage.dart';

class ListProduct extends StatelessWidget {
  final String name;
  final List<Product> snapshot;
  const ListProduct({
    Key? key,
    required this.name,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DefaultPage(),
                ));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ))
          ],
          title: const Text(
            'Products List',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Column(children: <Widget>[
                  Container(
                      height: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 700,
                      child: GridView.count(
                        crossAxisCount: 2,
                        scrollDirection: Axis.vertical,
                        children: snapshot
                            .map((e) => SingleProduct(
                                image: e.image, price: e.price, name: e.name))
                            .toList(),
                      ))
                ]),
              ],
            )));
  }
}
