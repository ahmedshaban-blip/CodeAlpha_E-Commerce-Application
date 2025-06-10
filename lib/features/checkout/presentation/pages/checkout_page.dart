import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';

class CheckoutPage extends StatefulWidget {
  final ProductModel products;

  const CheckoutPage({super.key, required this.products});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;
  final bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Checkout",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          elevation: 0,
          centerTitle: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cart Items",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                        leading: Image.network(
                          width: 56,
                          height: 56,
                          widget.products.image!,
                          fit: BoxFit.cover,
                        ),
                        title: Text(widget.products.title!,
                            style: const TextStyle(fontSize: 18)),
                        subtitle: const Text("Quantity: 1"),
                        trailing: Text("${widget.products.price.toString()} \$",
                            style: const TextStyle(fontSize: 18)),
                      ),
                    );
                  }),

                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        "${widget.products.price} \$",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text("Payment Method",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Column(
                    children:
                        ["Credit Card", "PayPal", "Google Pay"].map((method) {
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

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton(
                      onPressed: _selectedPaymentMethod == "Credit Card"
                          ? () async {
                              CircularProgressIndicator();

                              await CheckoutCubit().paymet_Method(
                                  amount: widget.products.price!,
                                  currency: "USD");
                            }
                          : null,
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
            );
          },
        ),
      ),
    );
  }
}
