import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ApiService apiService = ApiService();
  HomeCubit() : super(HomeInitial());

  // void fetchProducts() async {
  //   emit(HomeLoading());
  //   try {
  //     final response =
  //         await apiService.get(url: 'https://fakestoreapi.com/products');
  //     List<dynamic> data = response; // ممكن تكون List<dynamic>

  //     List<ProductModel> products =
  //         data.map((item) => ProductModel.fromJson(item)).toList();

  //     emit(HomeSuccess(products));
  //   } catch (e) {
  //     emit(HomeFailure(e.toString()));
  //   }
  // }
  void fetchProducts() async {
    if (isClosed) return; // ✅ تحقق قبل emit

    emit(HomeLoading());
    try {
      final response =
          await apiService.get(url: 'https://fakestoreapi.com/products');
      List<dynamic> data = response;

      List<ProductModel> products =
          data.map((item) => ProductModel.fromJson(item)).toList();

      if (isClosed) return; // ✅ تحقق قبل emit
      emit(HomeSuccess(products));
    } catch (e) {
      if (isClosed) return; // ✅ تحقق قبل emit
      emit(HomeFailure(e.toString()));
    }
  }

  // emit(HomeSuccess(result));
}
