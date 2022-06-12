import 'package:flutter/material.dart';

class ProductListSingleProduct extends StatelessWidget {
  const ProductListSingleProduct(
      {Key? key,
      required this.image,
      required this.price,
      required this.name,
      required this.location})
      : super(key: key);
  final String? image;
  final int? price;
  final String? name;
  final String? location;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        width: 162,
        child: Column(children: <Widget>[
          Container(
            height: 76,
            width: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image!))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${location}",
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.pin_drop))
            ],
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
