// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/core/services/stripe_sevrvice.dart';
import 'package:e_commerce/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  Future<void> paymet_Method({
    required double amount,
    required String currency,
  }) async {
    emit(CheckoutLoading());
    try {
      var result = await stripeService().makePayment(
        PaymentIntentInputModel(amount: amount, currency: "USD"),
      );
      emit(CheckoutSuccess(result));
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }
}
