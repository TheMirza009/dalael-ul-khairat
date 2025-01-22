import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String audioPath;

  const AudioPlayerWidget({Key? key, required this.audioPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayer _audioPlayer = AudioPlayer();

    // Load the audio file
    _audioPlayer.setAsset(audioPath);

    // Listen for the completion of the audio and reset when done
    _audioPlayer.playerStateStream.listen((playerState) async {
      if (playerState.processingState == ProcessingState.completed) {
        await _audioPlayer.seek(Duration.zero);  // Reset to the beginning
        await _audioPlayer.pause();  // Pause after reset
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Seek Bar
        StreamBuilder<Duration>(
          stream: _audioPlayer.positionStream,
          builder: (context, snapshot) {
            final currentPosition = snapshot.data ?? Duration.zero;
            return Slider(
              value: currentPosition.inMilliseconds.toDouble(),
              max: _audioPlayer.duration?.inMilliseconds.toDouble() ?? 0.0,
              onChanged: (value) async {
                await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
              },
            );
          },
        ),
        // Play/Pause Button
        Transform.translate(
          offset: Offset(0, -10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: StreamBuilder<bool>(
                  stream: _audioPlayer.playingStream,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return Icon(isPlaying ? Icons.pause : Icons.play_arrow);
                  },
                ),
                onPressed: () async {
                  if (_audioPlayer.playing) {
                    await _audioPlayer.pause();
                  } else {
                    await _audioPlayer.play();
                  }
                },
              ),
              // Reset Button
              // IconButton(
              //   icon: const Icon(Icons.refresh),
              //   onPressed: () async {
              //     await _audioPlayer.seek(Duration.zero);
              //     await _audioPlayer.pause();
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
