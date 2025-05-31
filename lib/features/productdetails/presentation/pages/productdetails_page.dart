import 'package:e_commerce/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';

class ProductdetailsPage extends StatefulWidget {
  final ProductModel products;

  const ProductdetailsPage({super.key, required this.products});

  @override
  State<ProductdetailsPage> createState() => _ProductdetailsPageState();
}

class _ProductdetailsPageState extends State<ProductdetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 0,
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    widget.products.imageurl,
                    fit: BoxFit.cover,
                    height: 450,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.products.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "EGP ${widget.products.price}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[700],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.pinkAccent,
                      size: 32,
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckoutPage(
                            products: widget.products,
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 56),
                    backgroundColor: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 6,
                  ),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
