import 'package:app2/views/commerce/detail_page.dart';

import 'package:app2/views/commerce/singleproducts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';
import '../../provider/product_provider.dart';

class Search extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchProduct = providerProvider.searchProductList(query);

    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchProduct
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailView(
                          location: e.Location,
                          image: e.image,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider providerProvider = Provider.of<ProductProvider>(context);
    List<Product> searchProduct = providerProvider.searchProductList(query);
    return GridView.count(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: searchProduct
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => DetailView(
                          image: e.image,
                          location: e.Location,
                          name: e.name,
                          price: e.price,
                        ),
                      ),
                    );
                  },
                  child: SingleProduct(
                    image: e.image,
                    name: e.name,
                    price: e.price,
                  ),
                ))
            .toList());
  }
}
