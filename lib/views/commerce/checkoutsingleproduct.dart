import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final int index;

  final int quantity;
  final int price;
  CheckOutSingleProduct({
    Key? key,
    required this.index,
    required this.quantity,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);
  @override
  _CheckOutSingleProductState createState() => _CheckOutSingleProductState();
}

TextStyle myStyle = TextStyle(fontSize: 16);
late ProductProvider productProvider;

class _CheckOutSingleProductState extends State<CheckOutSingleProduct> {
  Widget _buildImage() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.image),
        ),
      ),
    );
  }

  Widget _buildNameAndClosePart() {
    return Container(
      height: 30,
      width: 202,
      child: Text(
        widget.name,
        style: myStyle,
      ),
    );
  }

  Widget _buildCountOrNot() {
    return Container(
      height: 35,
      width: 200,
      color: Color(0xfff2f2f2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Quantity"),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              widget.quantity.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 20,
            ),
            onPressed: () {
              productProvider.deleteCheckoutProduct(widget.index);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 180,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildImage(),
                Container(
                  height: 160,
                  width: 202,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildNameAndClosePart(),
                        Text(
                          "ksh${widget.price.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        _buildCountOrNot(),
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
