// In your home_state.dart
import 'package:e_commerce/features/home/data/models/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  final int currentCategoryIndex;

  HomeSuccess(this.products, {this.currentCategoryIndex = 0});
}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}
