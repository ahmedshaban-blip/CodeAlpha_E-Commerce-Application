import 'package:e_commerce/features/home/data/models/home_model.dart';
import 'package:e_commerce/features/thankyou/presentation/pages/thankyou_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/checkout_cubit.dart';
import '../cubit/checkout_state.dart';

class CheckoutPage extends StatefulWidget {
  final List<ProductModel> products;

  const CheckoutPage({super.key, required this.products});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;

  // ✅ حساب السعر الإجمالي الصحيح (السعر × الكمية)
  double get totalPrice {
    return widget.products
        .fold(0.0, (sum, item) => sum + (item.price! * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[900],
          elevation: 0,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Items",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),

                  /// قائمة المنتجات مع الكمية الصحيحة
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.products[index];
                      final itemTotal =
                          product.price! * product.quantity; // ✅ السعر × الكمية

                      return Card(
                        margin: EdgeInsets.only(bottom: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // صورة المنتج
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  product.image!,
                                  width: 60.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60.w,
                                      height: 60.h,
                                      color: Colors.grey[300],
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),

                              // تفاصيل المنتج
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),

                                    // ✅ عرض الكمية الحقيقية
                                    Text(
                                      "Quantity: ${product.quantity}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4.h),

                                    // عرض السعر للوحدة
                                    Text(
                                      "Unit Price: \$${product.price!.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ✅ السعر الإجمالي للمنتج (سعر × كمية)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${itemTotal.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  if (product.quantity > 1)
                                    Text(
                                      "${product.quantity} × \$${product.price!.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  Divider(height: 32.h, thickness: 2),

                  /// ✅ السعر الإجمالي الصحيح
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// طريقة الدفع
                  Text("Payment Method",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children:
                          ["Credit Card", "PayPal", "Google Pay"].map((method) {
                        return RadioListTile<String>(
                          title:
                              Text(method, style: TextStyle(fontSize: 14.sp)),
                          value: method,
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                          activeColor: const Color(0xFF1A202C),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // ملخص الطلب
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Items (${widget.products.length}):",
                                style: TextStyle(fontSize: 14.sp)),
                            Text(
                                "${widget.products.fold(0, (sum, item) => sum + item.quantity)} pieces",
                                style: TextStyle(fontSize: 14.sp)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount:",
                                style: TextStyle(fontSize: 14.sp)),
                            Text("\$${totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _selectedPaymentMethod == "Credit Card"
                            ? () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                );

                                await CheckoutCubit().paymet_Method(
                                    amount: totalPrice, currency: "USD");

                                Navigator.pop(context); // Close the loader

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ThankYouPage(total: totalPrice),
                                    ));
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.h),
                          backgroundColor: Colors.blueGrey[900],
                          disabledBackgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          _selectedPaymentMethod == null
                              ? "Select Payment Method"
                              : "Place Order (\$${totalPrice.toStringAsFixed(2)})",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
