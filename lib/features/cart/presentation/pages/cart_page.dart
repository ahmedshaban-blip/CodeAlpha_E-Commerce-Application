import 'package:e_commerce/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cart_state.dart';
import 'package:e_commerce/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/features/checkout/presentation/pages/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سلة الشراء')),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cart = state.cartItems;

            if (cart.isEmpty) {
              return Center(child: Text('الكارت فارغ'));
            }

            // ✅ حساب السعر الإجمالي
            final total = cart.fold<double>(
              0.0,
              (sum, item) => sum + item.price,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (_, index) {
                      final product = cart[index];
                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.title),
                        subtitle:
                            Text('${product.price.toStringAsFixed(2)} \$'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<CartCubit>()
                                .removeFromCart(product.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                // ✅ السعر الإجمالي + زر Checkout
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الإجمالي: ${total.toStringAsFixed(2)} \$',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final cart =
                              (context.read<CartCubit>().state as CartLoaded)
                                  .cartItems;

                          if (cart.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(products: cart),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('السلة فارغة')),
                            );
                          }
                        },
                        child: Text('الدفع'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('الكارت فارغ'));
          }
        },
      ),
    );
  }
}
