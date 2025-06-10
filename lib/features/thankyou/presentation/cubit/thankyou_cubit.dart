import 'package:flutter_bloc/flutter_bloc.dart';
import 'thankyou_state.dart';

class ThankyouCubit extends Cubit<ThankyouState> {
  ThankyouCubit() : super(ThankyouInitial());

  Future<void> doSomething() async {
    emit(ThankyouLoading());
    try {
      // Call usecase
      // emit(ThankyouSuccess(result));
    } catch (e) {
      emit(ThankyouFailure(e.toString()));
    }
  }
}
