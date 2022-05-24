import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct(
      {Key? key, required this.image, required this.price, required this.name})
      : super(key: key);
  final String? image;
  final int? price;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 180,
        width: 160,
        //color: Colors.blue,
        child: Column(children: <Widget>[
          Container(
            height: 120,
            width: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image!))),
          ),
          Text(
            name!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("ksh ${price.toString()}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
