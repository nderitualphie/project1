import 'package:app2/model/usermodel.dart';
import 'package:app2/views/commerce/notifications.dart';
import 'package:app2/views/commerce/profile_page.dart';
import 'package:app2/views/commerce/provider/product_provider.dart';
import 'package:app2/views/commerce/search.dart';
import 'package:app2/views/commerce/singleproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:light_carousel/main/light_carousel.dart';

import 'package:provider/provider.dart';

import '../../model/product.dart';
import 'detail_page.dart';
import 'list_products.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

late ProductProvider productProvider;
var featuresnaphot;
var newarrivalssnapshot;

class _DefaultPageState extends State<DefaultPage> {
  Widget _buildNewArrivals() {
    List<Product> newarrivalProduct = productProvider.getnewArrivallist;
    List<Product> homeArrivalProduct = productProvider.homeArrivalRow;
    return Column(
      children: [
        Container(
          height: 40,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'New Arrival',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: (() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ListProduct(
                            name: "New Arrival",
                            snapshot: newarrivalProduct,
                          ),
                        ));
                      }),
                      child: const Text('See All',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ]),
        ),
        Row(
          children: productProvider.homeArrivalRow.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailView(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailView(
                              image: e.image, price: e.price, name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatured() {
    List<Product> featureProduct = productProvider.getfeaturelist;
    List<Product> homeFeaturedProduct = productProvider.getHomeFeaturelist;
    return Column(children: [
      Container(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListProduct(
                        name: "Featured",
                        snapshot: featureProduct,
                      ),
                    ));
                  }),
                  child: const Text('View More',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: productProvider.getHomeFeaturelist.map((e) {
          return Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailView(
                            image: e.image,
                            price: e.price,
                            name: e.name,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => DetailView(
                            image: e.image, price: e.price, name: e.name),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    price: e.price,
                    name: e.name,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ]);
  }

  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;
  bool profileColor = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Widget _buildImageSlider() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 250,
      child: LightCarousel(
        autoPlay: true,
        showIndicator: false,
        images: const [
          ExactAssetImage("lib/images/oranges.jpg"),
          ExactAssetImage("lib/images/cabbages.jpg"),
          ExactAssetImage("lib/images/beetroot.jpg"),
          ExactAssetImage("lib/images/fruits.jpg"),
          ExactAssetImage("lib/images/peaches.jpg"),
          ExactAssetImage("lib/images/carrot.jpg"),
          ExactAssetImage("lib/images/apples.jpg"),
        ],
      ),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(children: [
        _buildUserAccountsDrawer(),
        // UserAccountsDrawerHeader(
        //   accountName: Text(
        //     "Aliphonza",
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   currentAccountPicture: CircleAvatar(
        //     radius: 50,
        //     backgroundImage: AssetImage("lib/images/beetroot.jpg"),
        //   ),
        //   decoration: BoxDecoration(color: Colors.green),
        //   accountEmail:
        //       Text("alphie@gmail", style: TextStyle(color: Colors.black)),
        // ),
        ListTile(
          selected: profileColor,
          onTap: () {
            setState(() {
              aboutColor = false;
              homeColor = false;
              cartColor = false;
              contactUsColor = false;
              profileColor = true;
            });
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          selected: homeColor,
          onTap: () {
            setState(() {
              homeColor = true;
              contactUsColor = false;
              cartColor = false;
              aboutColor = false;
              profileColor = false;
            });
          },
          leading: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          selected: cartColor,
          onTap: () {
            setState(() {
              cartColor = true;
              homeColor = false;
              aboutColor = false;
              contactUsColor = false;
              profileColor = false;
            });
          },
          leading: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          title: const Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          selected: aboutColor,
          onTap: () {
            setState(() {
              aboutColor = true;
              homeColor = false;
              cartColor = false;
              contactUsColor = false;
              profileColor = false;
            });
          },
          leading: const Icon(
            Icons.info,
            color: Colors.black,
          ),
          title: const Text(
            'About',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          selected: contactUsColor,
          onTap: () {
            setState(() {
              contactUsColor = true;
              cartColor = false;
              homeColor = false;
              aboutColor = false;
              profileColor = false;
            });
          },
          leading: const Icon(
            Icons.phone,
            color: Colors.black,
          ),
          title: const Text(
            'Contact us',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.black,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ]),
    );
  }

  Widget _buildUserAccountsDrawer() {
    List<UserModel> userModel = productProvider.getUserModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName,
          style: TextStyle(color: Colors.black),
        ),
        currentAccountPicture: CircleAvatar(
            radius: 50,
            backgroundImage: e.userImage == null
                ? AssetImage("lib/images/beetroot.jpg") as ImageProvider
                : NetworkImage(e.userImage)),
        decoration: BoxDecoration(color: Colors.green),
        accountEmail: Text(e.email, style: TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getnewarrivaldata();
    productProvider.getfeaturedata();
    productProvider.gethomeArrivaldata();
    productProvider.getHomeFeatureData();
    productProvider.getUserdata();

    return Scaffold(
        key: _key,
        drawer: _buildMyDrawer(),
        appBar: AppBar(
          title: const Text(
            'Homepage',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
          actions: [NotificationButton()],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(children: [
              Container(
                child: Column(children: <Widget>[
                  Container(
                    //color: Colors.blue,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildImageSlider(),
                              ]),
                        ]),
                        //
                        const SizedBox(
                          height: 10,
                        ),
                        _buildFeatured(),
                        _buildNewArrivals(),
                      ],
                    ),
                  ),
                ]),
              )
            ])));
  }
}
