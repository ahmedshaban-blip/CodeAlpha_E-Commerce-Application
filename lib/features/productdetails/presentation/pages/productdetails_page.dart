import 'package:e_commerce/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';

class ProductdetailsPage extends StatelessWidget {
  final ProductModel products;

  const ProductdetailsPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Product Details")),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    products.imageurl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                products.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "EGP  ${products.price} ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CheckoutPage(
                        products: products,
                      );
                    },
                  ));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text("Buy Now"),
              )
            ],
          ),
        ));
  }
}
