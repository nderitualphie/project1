

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'provider/product_provider.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
   NotificationButton({Key? key}) : super(key: key);
  
 
  @override
  Widget build(BuildContext context) {
    ProductProvider  productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      badgeContent: Text(
        productProvider.getnotificationsList.toString(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      position: BadgePosition.topStart(top: 8, start: 8),
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          )),
    );
  }
}
