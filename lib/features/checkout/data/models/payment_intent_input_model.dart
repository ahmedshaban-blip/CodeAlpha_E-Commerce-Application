// class PaymentIntentInputModel {
//   final String amount;
//   final String currency;

//   PaymentIntentInputModel({required this.amount, required this.currency});

//   Map<String, dynamic> toJson() {
//     return {
//       'amount': amount + "00",
//       'currency': currency,
//     };
//   }
// }

class PaymentIntentInputModel {
  final double amount; // غيرنا من String لـ double
  final String currency;

  PaymentIntentInputModel({required this.amount, required this.currency});

  Map<String, dynamic> toJson() {
    int amountInCents = (amount * 100).round();
    return {
      'amount': amountInCents.toString(),
      'currency': currency,
    };
  }
}
