
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.price,
    required this.name,
    required this.image,
  }) : super(key: key);
  final int price;

  final String name;

  final String image;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Widget _buildBottomDetails(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(endName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
      ],
    );
  }

  int count = 1;
  Widget _buildSingleCartProduct() {
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
                        image: AssetImage('lib/images/${widget.image}'),
                      ),
                    )),
                Container(
                    height: 160,
                    width: 160,
                    child: ListTile(
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.name),
                            //IconButton(icon: Icon(Icons.),),
                            //const Text('Vegetable'),
                            Text(
                              "ksh ${widget.price.toString()}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: const [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
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
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55,
        width: 80,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text(
            'Procced to pay',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
             
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ))
        ],
        title: const Text(
          'Checkout Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSingleCartProduct(),
                _buildSingleCartProduct(),
                _buildSingleCartProduct(),
                _buildSingleCartProduct(),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomDetails(
                          startName: 'Your Price', endName: "ksh 40"),
                      _buildBottomDetails(startName: 'Discount', endName: "2%"),
                      _buildBottomDetails(
                          startName: 'Shipping', endName: "ksh 100"),
                      _buildBottomDetails(
                          startName: 'Total', endName: "ksh 138"),
                    ],
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
