import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void fetchUserProfile() async {
    emit(ProfileLoading());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final name = user.displayName ?? 'No name available';
        final email = user.email ?? 'No email found';
        final photoUrl = user.photoURL;

        emit(ProfileLoaded(name: name, email: email, photoUrl: photoUrl));
      } else {
        emit(ProfileError('No user found'));
      }
    } catch (e) {
      emit(ProfileError('Failed to fetch user data: $e'));
    }
  }
}
