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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: Products.length,
        itemBuilder: (BuildContext context, int index) {
          final products = Products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductdetailsPage(products: products),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        products.imageurl,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            products.description,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "${products.price} EGP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
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
