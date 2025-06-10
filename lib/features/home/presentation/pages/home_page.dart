import 'package:e_commerce/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeFailure) {
              return Center(
                  child: Text('Error: ${state.error}',
                      style: TextStyle(color: Colors.red, fontSize: 18)));
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
                                      borderRadius: BorderRadius.vertical(
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
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.image,
                                        size: 80,
                                        color: Colors.grey,
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${product.rating?.toStringAsFixed(1) ?? 'N/A'}',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '(${product.count ?? '0'} reviews)',
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${product.price?.toStringAsFixed(2) ?? 'N/A'}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.ProductdetailsPage,
                                          arguments: product,
                                        );
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
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
                  BottomNavigationBar(
                    currentIndex: 0,
                    onTap: (index) {
                      context.read<HomeCubit>().changeCategory([
                            'electronics',
                            'jewelery',
                            'men\'s clothing',
                            'women\'s clothing'
                          ][index]);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.computer,
                          color: Colors.blue,
                        ),
                        label: 'Electronics',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.diamond,
                          color: Colors.pink,
                        ),
                        label: 'Jewelery',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.male,
                          color: Colors.blueGrey,
                        ),
                        label: 'Men\'s clothing',
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.female,
                          color: Colors.pinkAccent,
                        ),
                        label: 'Women\'s clothing',
                      ),
                    ],
                  ),
                ],
              );
            }
            return const Center(
                child: Text('Press button to load products',
                    style: TextStyle(fontSize: 16)));
          },
        ),
      ),
    );
  }
}
