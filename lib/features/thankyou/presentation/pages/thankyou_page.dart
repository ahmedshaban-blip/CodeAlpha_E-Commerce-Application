import 'package:e_commerce/features/thankyou/presentation/pages/custtom_app_bar.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/thank_you_view_body.dart';
import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  final double total;

  const ThankYouPage({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Transform.translate(
          offset: const Offset(0, -16),
          child: ThankYouViewBody(
            total: total,
          )),
    );
  }
}
