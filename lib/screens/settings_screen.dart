// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';
import 'package:flutter_app_game/widgets/background_pattern.dart';
import 'package:flutter_app_game/services/audio_service.dart'; // NEW: Import AudioService

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSoundEnabled =
      AudioService.isSoundEnabled; // Get initial state from service

  @override
  void initState() {
    super.initState();
    // No need to load from prefs here, AudioService.init() in main does it.
    // We just read the current state from AudioService.
  }

  Future<void> _toggleSound(bool value) async {
    await AudioService.setSoundEnabled(value); // Update setting via service
    setState(() {
      _isSoundEnabled = value; // Update local state
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSoundEnabled ? 'បានបើកសម្លេង' : 'បានបិទសម្លេង'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ការកំណត់'),
        backgroundColor: AppColors.primaryDarkBlue,
        foregroundColor: AppColors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDarkBlue, AppColors.primaryLightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            const BackgroundPattern(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ជម្រើសកម្មវិធី',
                    style: AppStyles.headerTextStyle.copyWith(
                      fontSize: 26,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: AppColors.whiteOpacity(0.9),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'សម្លេង',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDarkBlue,
                                ),
                              ),
                              Switch(
                                value: _isSoundEnabled,
                                onChanged: _toggleSound,
                                activeColor: AppColors.successGreen,
                                inactiveThumbColor: AppColors.errorRed,
                                inactiveTrackColor: AppColors.errorRed
                                    .withOpacity(0.5),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'អំពីកម្មវិធី',
                    style: AppStyles.headerTextStyle.copyWith(
                      fontSize: 26,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: AppColors.whiteOpacity(0.9),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'កំណែកម្មវិធី: 0007',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryDarkBlue.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'បង្កើតដោយ: [B.N]',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryDarkBlue.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'សម្រាប់សំណួរ ឬមតិកែលម្អ សូមទាក់ទងមកកាន់: 0001bunna@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryDarkBlue.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
