import 'package:e_commerce/features/home/data/models/home_model.dart';
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

  double get totalPrice {
    return widget.products.fold(0, (sum, item) => sum + item.price!);
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

                  /// قائمة المنتجات
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.products[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ListTile(
                          leading: Image.network(
                            product.image!,
                            width: 56.w,
                            height: 56.h,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.title!,
                              style: TextStyle(fontSize: 16.sp)),
                          subtitle: Text("Quantity: 1",
                              style: TextStyle(fontSize: 12.sp)),
                          trailing: Text(
                            "${product.price} \$",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      );
                    },
                  ),

                  Divider(height: 32.h),

                  /// السعر الإجمالي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      Text(
                        "${totalPrice.toStringAsFixed(2)} \$",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// طريقة الدفع
                  Text("Payment Method",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),

                  Column(
                    children:
                        ["Credit Card", "PayPal", "Google Pay"].map((method) {
                      return RadioListTile<String>(
                        title: Text(method, style: TextStyle(fontSize: 14.sp)),
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

                  SizedBox(height: 24.h),

                  Center(
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
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200.w, 50.h),
                        backgroundColor: Colors.blueGrey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
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
