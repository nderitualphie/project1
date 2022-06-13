import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    this.location,
  }) : super(key: key);
  final String? image;
  final int? price;
  final String? name;
  final String? location;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 162,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
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
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.pin_drop,
                      ))
                ],
              ),
              Text(
                name!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text("ksh ${price.toString()}",
                  style: const TextStyle(
                    fontSize: 14,
                  )),
            ]),
      ),
    );
  }
}
