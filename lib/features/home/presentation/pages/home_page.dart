// ignore_for_file: deprecated_member_use

import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce/features/cart/presentation/pages/cart_page.dart';
import 'package:e_commerce/features/productdetails/presentation/pages/productdetails_page.dart';
import 'package:e_commerce/features/profile/presentation/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..fetchProducts(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          actions: [
            // Profile Icon
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile',
              onPressed: () {
                Navigator.pushNamed(context, Routes.ProfileScreen);
              },
            ),

            // Logout Icon
          ],
          title: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final index = context.watch<HomeCubit>().currentIndex;
              final titles = [
                'Electronics',
                'Jewelery',
                'Men\'s Clothing',
                'Women\'s Clothing',
              ];
              return Text(titles[index]);
            },
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeFailure) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              );
            } else if (state is HomeSuccess) {
              final products = state.products;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          color: Theme.of(context).cardColor,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              product.image != null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        product.image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.image,
                                        size: 80,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.3),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? 'No Title',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber[700],
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          product.rating?.toStringAsFixed(1) ??
                                              'N/A',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '(${product.count ?? '0'} reviews)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductdetailsPage(
                                                products: product),
                                          ),
                                        );
                                        ;
                                      },
                                      child: const Text('Details'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).colorScheme.surface,
                      primaryColor: Theme.of(context).colorScheme.primary,
                      splashColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      currentIndex: context.watch<HomeCubit>().currentIndex,
                      onTap: (index) {
                        final categories = [
                          'electronics',
                          'jewelery',
                          'men\'s clothing',
                          'women\'s clothing',
                        ];
                        if (index == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartPage(),
                            ),
                          );
                        } else {
                          context
                              .read<HomeCubit>()
                              .changeCategory(categories[index], index);
                        }
                      },
                      selectedItemColor: Theme.of(context).colorScheme.primary,
                      unselectedItemColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.computer),
                          label: 'Electronics',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.diamond),
                          label: 'Jewelery',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.male),
                          label: 'Men\'s clothing',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.female),
                          label: 'Women\'s clothing',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.card_travel),
                          label: 'Cart',
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            return const Center(
              child: Text(
                'Press button to load products',
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
