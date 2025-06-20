

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkMode;
  final bool notificationsEnabled;

  SettingsLoaded({
    required this.isDarkMode,
    required this.notificationsEnabled,
  });

  SettingsLoaded copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
  }) {
    return SettingsLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
