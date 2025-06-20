

import 'package:e_commerce/features/accountsettings/presentation/cubit/accountsettings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsLoaded(
          isDarkMode: false,
          notificationsEnabled: true,
        ));

  void toggleDarkMode() {
    if (state is SettingsLoaded) {
      final current = state as SettingsLoaded;
      emit(current.copyWith(isDarkMode: !current.isDarkMode));
    }
  }

  void toggleNotifications() {
    if (state is SettingsLoaded) {
      final current = state as SettingsLoaded;
      emit(current.copyWith(
          notificationsEnabled: !current.notificationsEnabled));
    }
  }
}
