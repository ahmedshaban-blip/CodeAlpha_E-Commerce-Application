import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final ProductModel products;

  const CheckoutPage({super.key, required this.products});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  String? _selectedPaymentMethod;

  // Stub: Replace with dynamic calculation later

  void _placeOrder() {
    if (_selectedPaymentMethod == null ||
        _addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Please select a payment method and enter a delivery address")),
      );
      return;
    }

    // Stub: Replace with real order submission logic
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Placed"),
        content: const Text("Your order has been placed successfully."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Cart Items",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Text("View cart",
                      style: TextStyle(
                          color: Color(0xFF1A202C),
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Placeholder cart item list
            ...List.generate(1, (index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image.asset(
                    widget.products.imageurl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(widget.products.name,
                      style: const TextStyle(fontSize: 18)),
                  subtitle: const Text("Quantity: 1"),
                  trailing: Text("${widget.products.price.toString()} EGP",
                      style: const TextStyle(fontSize: 18)),
                ),
              );
            }),

            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total: ",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  "${widget.products.price} EGP",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text("Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              children: ["Credit Card", "PayPal", "Google Pay"].map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                  activeColor: const Color(0xFF1A202C),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            const Text("Delivery Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter delivery address",
                hintStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
