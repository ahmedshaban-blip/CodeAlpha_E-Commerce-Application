import 'package:e_commerce/core/cubit/theme/theme_cubit.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/features/accountsettings/presentation/cubit/accountsettings_cubit.dart';
import 'package:e_commerce/features/accountsettings/presentation/cubit/accountsettings_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Settings'),
          centerTitle: true,
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoaded) {
              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Preferences',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    value: context.watch<ThemeCubit>().state.themeMode ==
                        ThemeMode.dark,
                    onChanged: (_) {
                      final isDark =
                          context.read<ThemeCubit>().state.themeMode ==
                              ThemeMode.dark;

                      context.read<ThemeCubit>().toggleTheme();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isDark
                              ? 'تم إيقاف الوضع الليلي'
                              : 'تم تفعيل الوضع الليلي'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    title: const Text('Dark Mode'),
                    secondary: const Icon(Icons.dark_mode),
                  ),
                  SwitchListTile(
                    value: state.notificationsEnabled,
                    onChanged: (_) =>
                        context.read<SettingsCubit>().toggleNotifications(),
                    title: const Text('Enable Notifications'),
                    secondary: const Icon(Icons.notifications),
                  ),
                  const Divider(height: 40),
                  const Text(
                    'Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Change Password'),
                    onTap: () async {
                      final currentPasswordController = TextEditingController();
                      final newPasswordController = TextEditingController();
                      final formKey = GlobalKey<FormState>();

                      final shouldProceed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Change Password'),
                            content: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: currentPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Current Password',
                                    ),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Enter current password'
                                            : null,
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: newPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'New Password',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty)
                                        return 'Enter new password';
                                      if (value.length < 6)
                                        return 'Minimum 6 characters';
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pop(context, true);
                                  }
                                },
                                child: const Text('Update'),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldProceed == true) {
                        final user = FirebaseAuth.instance.currentUser;
                        final email = user?.email;
                        final currentPassword = currentPasswordController.text;
                        final newPassword = newPasswordController.text;

                        if (user != null && email != null) {
                          final cred = EmailAuthProvider.credential(
                            email: email,
                            password: currentPassword,
                          );

                          try {
                            await user.reauthenticateWithCredential(cred);
                            await user.updatePassword(newPassword);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Password updated successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.message}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout'),
                    onTap: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Logout'),
                          content:
                              const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.LoginScreen,
                            (route) => false,
                          );
                        }
                      }
                    },
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
