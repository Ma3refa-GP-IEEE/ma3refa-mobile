import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioService {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isMuted = false;

  void toggleMute() {
    isMuted = !isMuted;
    if (isMuted) {
      stopSound();
    }
  }

  Future<void> playAssetSound(String assetPath) async {
    if (isMuted) return;
    try {
      await _audioPlayer.stop();
      await _audioPlayer.dispose();

      _audioPlayer = AudioPlayer();

      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Failed to play sound asset "$assetPath": $e');
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }
}
