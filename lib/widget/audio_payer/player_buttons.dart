// player_buttons.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// A `Row` of buttons that interact with audio.
///
/// The order is: shuffle, previous, play/pause/restart, next, repeat.
class PlayerButtons extends StatelessWidget {
  const PlayerButtons(this._audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<SequenceState?>(
          stream: _audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _previousButton();
          },
        ),
        // Play/pause/restart
        StreamBuilder<PlayerState>(
          stream: _audioPlayer.playerStateStream,
          builder: (_, snapshot) {
            final playerState = snapshot.data;
            return playPauseButton(playerState!);
          },
        ),
        // Next
        StreamBuilder<SequenceState?>(
          stream: _audioPlayer.sequenceStateStream,
          builder: (_, __) {
            return _nextButton();
          },
        ),
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
        margin: EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: CircularProgressIndicator(),
      );
    } else if (_audioPlayer.playing != true) {
      return IconButton(
        icon: Icon(
          Icons.play_circle_filled,
          color: Colors.white,
        ),
        iconSize: 64.0,
        onPressed: _audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: Icon(
          Icons.pause,
          color: Colors.white,
        ),
        iconSize: 64.0,
        onPressed: _audioPlayer.pause,
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.replay,
          color: Colors.white,
        ),
        iconSize: 64.0,
        onPressed: () =>
            _audioPlayer.seek(Duration.zero, index: _audioPlayer.effectiveIndices?.first),
      );
    }
  }

  Widget _previousButton() {
    return IconButton(
      icon: Icon(
        Icons.skip_previous,
        color: Colors.white,
      ),
      iconSize: 45.0,
      onPressed: _audioPlayer.hasPrevious ? _audioPlayer.seekToPrevious : null,
    );
  }

  /// A next button. Tapping it will seek to the next audio in the list.
  Widget _nextButton() {
    return IconButton(
      icon: Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
      iconSize: 45.0,
      onPressed: _audioPlayer.hasNext ? _audioPlayer.seekToNext : null,
    );
  }
}
