import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ApiService apiService = ApiService();
  String currentCategory = 'laptops'; // Start with laptops
  final Map<String, String> categoryUrls = {
    'jewelery': 'https://fakestoreapi.com/products/category/jewelery',
    'laptops': 'https://dummyjson.com/products/category/laptops',
    'smartphones': 'https://dummyjson.com/products/category/smartphones',
    'tablets': 'https://dummyjson.com/products/category/tablets',
    'men\'s clothing':
        'https://fakestoreapi.com/products/category/men\'s%20clothing',
    'women\'s clothing':
        'https://fakestoreapi.com/products/category/women\'s%20clothing',
  };
  HomeCubit() : super(HomeInitial());

  // Method to change category and fetch products for that category
  void changeCategory(String category) async {
    if (isClosed) return;

    currentCategory = category;
    emit(HomeLoading());

    try {
      String apiUrl = _getApiUrl(category);
      final response = await apiService.get(url: apiUrl);

      List<ProductModel> products;

      // Handle different API response structures
      if (category == 'jewelery' || category.contains("clothing")) {
        // FakeStoreAPI returns array directly
        List<dynamic> data = response;
        products = data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        // DummyJSON returns object with 'products' array
        Map<String, dynamic> data = response;
        List<dynamic> productsData = data['products'];
        products = productsData
            .map((item) => ProductModel.fromDummyJson(item))
            .toList();
      }

      if (isClosed) return;
      emit(HomeSuccess(products));
    } catch (e) {
      if (isClosed) return;
      emit(HomeFailure(e.toString()));
    }
  }

  // Get the appropriate API URL based on category
  String _getApiUrl(String category) {
    return categoryUrls[category] ??
        'https://dummyjson.com/products/category/laptops';
  }

  // Fetch all products (for initial load)
  void fetchProducts() async {
    if (isClosed) return;
    changeCategory(currentCategory);
  }
}
