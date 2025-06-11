import 'package:e_commerce/features/thankyou/presentation/pages/ThankYouCard.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/custom_check_icon.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/custom_dashed_line.dart';
import 'package:flutter/material.dart';

class ThankYouViewBody extends StatelessWidget {
  final double total;

  const ThankYouViewBody({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouCard(
            total: total,
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: const CustomDashedLine(),
          ),
          Positioned(
              left: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckIcon(),
          ),
        ],
      ),
    );
  }
}
