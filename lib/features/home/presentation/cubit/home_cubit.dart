import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  int currentIndex = 0;

  ApiService apiService = ApiService();
  String currentCategory = 'laptops';

  final Map<String, String> categoryUrls = {
    'electronics': 'https://fakestoreapi.com/products/category/electronics',
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

  void changeCategory(String category, int index) async {
    if (isClosed) return;

    currentIndex = index;
    currentCategory = category;
    emit(HomeLoading());

    try {
      String apiUrl = _getApiUrl(category);
      final response = await apiService.get(url: apiUrl);

      List<ProductModel> products;

      if (category == 'jewelery' ||
          category.contains("clothing") ||
          category == 'electronics') {
        List<dynamic> data = response;
        products = data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
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

  String _getApiUrl(String category) {
    return categoryUrls[category] ??
        'https://dummyjson.com/products/category/laptops';
  }

  void fetchProducts() async {
    if (isClosed) return;
    changeCategory(currentCategory, currentIndex);
  }
}
