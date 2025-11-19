import 'package:e_commerce/core/services/cart_shared_service.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<ProductModel> _cart = [];

  List<ProductModel> get cart => _cart;

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final products = await CartSharedService.getCartProducts();
      print("🛒 Loaded products from SharedPreferences: $products");
      emit(CartLoaded(items: products));
    } catch (e, stackTrace) {
      emit(CartError("فشل تحميل الكارت"));
    }
  }

  Future<void> addToCart(ProductModel product) async {
    await CartSharedService.saveProductToCart(product);
    await loadCart();
  }

  void updateQuantity(int productId, int newQuantity) {
    
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = currentState.items.map((item) {
        if (item.id == productId) {
          
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();

      emit(CartLoaded(items: updatedCart));
    }
  }

  Future<void> removeFromCart(int productId) async {
    await CartSharedService.removeProductFromCart(productId);
    await loadCart();
  }

  Future<void> clearCart() async {
    await CartSharedService.clearCart();
    await loadCart();
  }
}
