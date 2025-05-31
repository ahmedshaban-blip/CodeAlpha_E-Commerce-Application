import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final ProductModel products;

  const CheckoutPage({Key? key, required this.products}) : super(key: key);

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
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Cart Items",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Placeholder cart item list
            ...List.generate(1, (index) {
              return ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: Text(widget.products.name),
                subtitle: const Text("Quantity: 1"),
                trailing: Text("${widget.products.price.toString()} EGP"),
              );
            }),

            const Divider(height: 32),
            Text("Total: ${widget.products.price} EGP",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 24),

            const Text("Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter delivery address",
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton(
                onPressed: _placeOrder,
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
