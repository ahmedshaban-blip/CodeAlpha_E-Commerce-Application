abstract class ThankyouState {}

class ThankyouInitial extends ThankyouState {}

class ThankyouLoading extends ThankyouState {}

class ThankyouSuccess extends ThankyouState {
  // final result;
  // Success(this.result);
}

class ThankyouFailure extends ThankyouState {
  final String error;
  ThankyouFailure(this.error);
}
