import 'package:e_commerce/core/utils/style.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/card_info_widget.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/payment_info_item.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/total_price_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThankYouCard extends StatelessWidget {
  final double total;

  const ThankYouCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MM/dd/yyyy').format(now);
    final String formattedTime = DateFormat('hh:mm a').format(now);

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50 + 16, left: 22, right: 22),
        child: Column(
          children: [
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Styles.style25,
            ),
            Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: Styles.style20,
            ),
            const SizedBox(
              height: 42,
            ),
            PaymentItemInfo(
              title: 'Date',
              value: formattedDate,
            ),
            const SizedBox(
              height: 20,
            ),
            PaymentItemInfo(
              title: 'Time',
              value: formattedTime,
            ),
            const SizedBox(
              height: 20,
            ),
            // const PaymentItemInfo(
            //   title: 'To',
            //   value: 'Sam Louis',
            // ),
            const Divider(
              height: 60,
              thickness: 2,
            ),
            TotalPrice(title: 'Total', value: '\$${total.toStringAsFixed(2)}'),
            const SizedBox(
              height: 30,
            ),
            // const CardInfoWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  FontAwesomeIcons.barcode,
                  size: 64,
                ),
                Container(
                  width: 113,
                  height: 58,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1.50, color: Color(0xFF34A853)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'PAID',
                      textAlign: TextAlign.center,
                      style: Styles.style24
                          .copyWith(color: const Color(0xff34A853)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ((MediaQuery.sizeOf(context).height * .2 + 20) / 2) - 29,
            ),
          ],
        ),
      ),
    );
  }
}
