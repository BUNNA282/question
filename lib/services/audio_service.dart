// lib/services/audio_service.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isSoundEnabled = true; // Default to enabled

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isSoundEnabled = prefs.getBool('isSoundEnabled') ?? true;
  }

  static Future<void> setSoundEnabled(bool enabled) async {
    _isSoundEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSoundEnabled', enabled);
    if (!enabled) {
      await _player
          .stop(); // Stop any currently playing sound if sound is disabled
    }
  }

  static bool get isSoundEnabled => _isSoundEnabled;

  static Future<void> playSound(String soundPath) async {
    if (_isSoundEnabled) {
      // Use AssetSource for local assets
      await _player.play(AssetSource(soundPath), mode: PlayerMode.lowLatency);
    }
  }

  // Specific sound functions for convenience
  static Future<void> playButtonClick() async {
    await playSound('sounds/button_click.mp3');
  }

  static Future<void> playCorrectAnswer() async {
    await playSound('sounds/correct_answer.mp3');
  }

  static Future<void> playWrongAnswer() async {
    await playSound('sounds/wrong_answer.mp3');
  }

  static Future<void> playQuizComplete() async {
    await playSound('sounds/quiz_complete.mp3');
  }

  static Future<void> dispose() async {
    await _player.dispose(); // Release resources when done
  }
}
