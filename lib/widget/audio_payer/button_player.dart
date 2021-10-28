// player_buttons.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// A `Row` of buttons that interact with audio.
///
/// The order is: shuffle, previous, play/pause/restart, next, repeat.
class ButtonPlayer extends StatelessWidget {
  const ButtonPlayer(this._audioPlayer, this.index, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        // Play/pause/restart
        StreamBuilder<PlayerState>(
          stream: _audioPlayer.playerStateStream,
          builder: (_, snapshot) {
            final playerState = snapshot.data;
            return playPauseButton(playerState!);
          },
        ),
        // Next

      ],
    );
  }

  /// A button that plays or pauses the audio.
  ///
  /// If the audio is playing, a pause button is shown.
  /// If the audio has finished playing, a restart button is shown.
  /// If the audio is paused, or not started yet, a play button is shown.
  /// If the audio is loading, a progress indicator is shown.
  Widget playPauseButton(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8),
        width: 40.0,
        height: 40.0,
        child: CircularProgressIndicator(),
      );
    } else if (_audioPlayer.playing != true) {
      return IconButton(
        icon: Icon(
          Icons.play_circle_filled,
          color: Colors.white,
        ),
        iconSize: 40.0,
        onPressed: _audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: Icon(
          Icons.pause,
          color: Colors.white,
        ),
        iconSize: 40.0,
        onPressed: _audioPlayer.pause,
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.replay,
          color: Colors.white,
        ),
        iconSize: 40.0,
        onPressed: () =>
            _audioPlayer.seek(Duration.zero, index: index),
      );
    }
  }


}
