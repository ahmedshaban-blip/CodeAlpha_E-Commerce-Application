import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel() : super();

  factory CartModel.fromJson(Map<String, dynamic> json) {
    // TODO: Map JSON to model
    return CartModel();
  }
}
