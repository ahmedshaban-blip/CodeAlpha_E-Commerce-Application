import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:e_commerce/features/productdetails/presentation/pages/productdetails_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<ProductModel> Products = [
    ProductModel(
        id: 1,
        name: "T-shirt preimum",
        imageurl: "assets/images/preimum.jpg",
        price: 190,
        description: "This is a  Preimum T-shirt"),
    ProductModel(
        id: 2,
        name: "Men-s-Two-Piece-Business-Suit",
        imageurl: "assets/images/Men-s-Two-Piece-Business-Suit-Bl.jpg",
        price: 1900,
        description: "This is a  Men-s-Two-Piece-Business-Suit"),
    ProductModel(
        id: 3,
        name: "T-shirt Polo",
        imageurl: "assets/images/T-shirt Polo.jpg",
        price: 320,
        description: "This is a  T-shirt Polo"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ListView.builder(
        itemCount: Products.length,
        itemBuilder: (BuildContext context, int index) {
          final products = Products[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductdetailsPage(products: products),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${products.id}- ${products.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      products.imageurl,
                      height: 150,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      products.description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${products.price} EGP",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
