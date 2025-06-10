import 'dart:convert';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartSharedService {
  static const _cartKey = 'cart_items';

  /// حفظ منتج داخل الكارت
  static Future<void> saveProductToCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);

    List<Map<String, dynamic>> cartList = [];

    if (cartString != null) {
      try {
        List decoded = json.decode(cartString);
        cartList = List<Map<String, dynamic>>.from(decoded);
      } catch (e) {
        // لو حصل خطأ في الديكود
        cartList = [];
      }
    }

    final isAlreadyAdded = cartList.any((item) => item['id'] == product.id);
    if (!isAlreadyAdded) {
      cartList.add(product.toJson());
      await prefs.setString(_cartKey, json.encode(cartList));
    }
  }

  /// استرجاع كل المنتجات
  static Future<List<ProductModel>> getCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString('cart_items');

    if (cartString != null) {
      try {
        final List decoded = json.decode(cartString);
        return decoded.map((item) => ProductModel.fromJson(item)).toList();
      } catch (e) {
        print("❌ خطأ أثناء فك تشفير البيانات: $e");
        // حذف البيانات التالفة تلقائيًا
        await prefs.remove('cart_items');
      }
    }

    return [];
  }

  /// حذف منتج معين
  static Future<void> removeProductFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);

    if (cartString != null) {
      List decoded = json.decode(cartString);
      List updatedList =
          decoded.where((item) => item['id'] != productId).toList();
      await prefs.setString(_cartKey, json.encode(updatedList));
    }
  }

  /// مسح كل الكارت
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
