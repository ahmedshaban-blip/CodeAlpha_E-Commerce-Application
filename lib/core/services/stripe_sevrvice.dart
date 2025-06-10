// ignore_for_file: camel_case_types

import 'package:dio/dio.dart';
import 'package:e_commerce/core/services/api_service.dart';
import 'package:e_commerce/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:e_commerce/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class stripeService {
  final ApiService apiService = ApiService();

  final String url = "https://api.stripe.com/v1/payment_intents";

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    {
      var response = await apiService.post(
          contentType: Headers.formUrlEncodedContentType,
          url: url,
          body: paymentIntentInputModel.toJson(), // ✅ هنا التعديل
          token: dotenv.env['secret_key']!);

      var paymentintentModel = PaymentIntentModel.fromJson(response);

      return paymentintentModel;
    }
  }

  initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: 'Ahmed',
    ));
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // المستخدم ألغى الدفع، ممكن تتجاهل أو تعرض رسالة بسيطة
        print('Payment cancelled by user.');
      } else {
        rethrow; // لو خطأ تاني، ارفع الخطأ عادي
      }
    } catch (e) {
      rethrow; // أي خطأ آخر
    }
  }

  Future makePayment(PaymentIntentInputModel paymentIntentInputModel) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
