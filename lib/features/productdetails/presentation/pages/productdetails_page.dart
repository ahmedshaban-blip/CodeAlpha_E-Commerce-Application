import 'package:e_commerce/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductdetailsPage extends StatefulWidget {
  final ProductModel products;

  const ProductdetailsPage({super.key, required this.products});

  @override
  State<ProductdetailsPage> createState() => _ProductdetailsPageState();
}

class _ProductdetailsPageState extends State<ProductdetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: theme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation ?? 0,
        centerTitle: theme.appBarTheme.centerTitle ?? true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        iconTheme: theme.appBarTheme.iconTheme,
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
                      color: theme.shadowColor.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.products.image!,
                    fit: BoxFit.cover,
                    height: 450,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 450,
                        color: theme.cardColor,
                        child: Icon(
                          Icons.broken_image,
                          size: 100,
                          color: theme.hintColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.products.title ?? '',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "\$ ${widget.products.price}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final cartCubit = context.read<CartCubit>();
                      await cartCubit.addToCart(widget.products);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cartCubit,
                            child: CartPage(),
                          ),
                        ),
                      );
                      ;
                    },
                    child: Text(
                      "Add to cart",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CheckoutPage(
                            products: [widget.products], // ✅ الحل هنا
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.colorScheme.onPrimary,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    "Checkout",
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
