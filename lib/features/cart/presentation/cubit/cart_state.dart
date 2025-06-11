import 'package:e_commerce/features/home/data/models/home_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductModel> items; // 👈 قد يكون هذا هو الاسم الصحيح

  CartLoaded({
    required this.items,
  });
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
