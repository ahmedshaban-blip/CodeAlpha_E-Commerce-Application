import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/thankyou_cubit.dart';
import '../cubit/thankyou_state.dart';

class ThankyouPage extends StatelessWidget {
  const ThankyouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThankyouCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Thankyou Page')),
        body: BlocBuilder<ThankyouCubit, ThankyouState>(
          builder: (context, state) {
            if (state is ThankyouLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ThankyouFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const Center(child: Text('Thankyou Page'));
          },
        ),
      ),
    );
  }
}
