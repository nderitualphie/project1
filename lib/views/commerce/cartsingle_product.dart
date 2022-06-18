import 'package:app2/views/commerce/homepage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class CartSingleProduct extends StatefulWidget {
  final String? name;
  final String? image;
  int quantity;
  final int? price;
  final int index;
  final bool isCount;

  CartSingleProduct({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.index,
    required this.isCount,
  }) : super(key: key);

  @override
  State<CartSingleProduct> createState() => _CartSingleProductState();
}

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    productProvider.getCheckOutData(
        quantity: widget.quantity,
        image: widget.image!,
        name: widget.name!,
        price: widget.price!);

    return Container(
      height: 180,
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.image!),
                      ),
                    )),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: widget.isCount == false ? 180 : 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.name!,
                                style: TextStyle(fontSize: 14),
                              ),
                              IconButton(
                                  onPressed: () {
                                    productProvider
                                        .deleteCartProduct(widget.index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  ))
                            ],
                          ),
                        ),
                        Text(
                          "ksh ${widget.price.toString()}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: widget.isCount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget.quantity > 1) {
                                                widget.quantity--;
                                                productProvider.getCheckOutData(
                                                    quantity: widget.quantity,
                                                    image: widget.image!,
                                                    name: widget.name!,
                                                    price: widget.price!);
                                              }
                                            });
                                          },
                                          child: const Icon(Icons.remove)),
                                      Text(
                                        widget.quantity.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.quantity++;
                                              productProvider.getCheckOutData(
                                                  quantity: widget.quantity,
                                                  image: widget.image!,
                                                  name: widget.name!,
                                                  price: widget.price!);
                                            });
                                          },
                                          child: const Icon(Icons.add)),
                                    ])
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(widget.quantity.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
