import 'package:app2/views/commerce/cart_page.dart';
import 'package:app2/views/commerce/notifications.dart';

import 'homepage.dart';
import 'provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  const DetailView(
      {Key? key,
      required this.image,
      required this.name,
      required this.price,
      required this.location})
      : super(key: key);
  final String image;
  final String name;
  final int price;
  final String location;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late ProductProvider productProvider;
  Widget _buildButton() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 320,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.all(10),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () {
                  productProvider.getCartData(
                      image: widget.image,
                      name: widget.name,
                      quantity: count,
                      price: widget.price);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
                },
                child: const Text(
                  'Proceed to Cart',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _builddescriptionText() {
    return Column(
      children: [
        Container(
          height: 230,
          child: Wrap(children: const [
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius rhoncus ipsum, at iaculis mauris euismod id. Praesent vel placerat lorem, vitae bibendum massa. Quisque fringilla dui dolor, porta dictum nulla scelerisque et. Fusce scelerisque tempus nunc quis cursus. Fusce et est ac nunc consequat fringilla. Donec risus ex, scelerisque ac ante finibus, egestas maximus eros. In aliquet egestas sapien sed hendrerit. Cras sed congue ligula. Nunc sodales arcu eu nisl faucibus, eu aliquet urna congue. Nulla dapibus massa sed enim elementum, commodo rutrum felis gravida. ',
              style: TextStyle(fontSize: 15),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              'Quantity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (count > 1) {
                          count--;
                        }
                      });
                    },
                    child: const Icon(Icons.remove)),
                Text(
                  count.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                    },
                    child: const Icon(Icons.add)),
              ],
            ),
          ),
        ]),
      ],
    );
  }

  Widget _buildImage() {
    return Column(children: [
      Center(
        child: Container(
          width: 330,
          child: Card(
            child: Container(
              //padding: EdgeInsets.all(5),
              child: Container(
                height: 220,
               
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.image),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildDescriptionPart() {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Location: ${widget.location}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.pin_drop))
                    ],
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text('ksh ${widget.price.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                      )),
                  const Text('Description',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  int count = 1;
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
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
          actions: [NotificationButton()],
          title: const Text(
            'Detail Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImage(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildDescriptionPart(),
                          SizedBox(
                            height: 10,
                          ),
                          _builddescriptionText(),
                          _buildQuantity(),
                          _buildButton(),
                          //
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
