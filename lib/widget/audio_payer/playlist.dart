/*
 * File: playlist.dart
 * Project: Flutter music player
 * Created Date: Thursday February 18th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/// A list of tiles showing all the audio sources added to the audio player.
///
/// Audio sources are displayed with a `ListTile` with a leading image (the
/// artwork), and the title of the audio source.
class Playlist extends StatelessWidget {
  const Playlist(this._audioPlayer, );

  final AudioPlayer _audioPlayer;
  // final List<AudioSource> audiosService;
  // List <Duration>timeDuration = '' as List<Duration>;
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: _audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        // bool inPlay=false;
        final state = snapshot.data;
        if (state == null) return CircularProgressIndicator();
        final sequence = state.sequence;
        Duration? totalDurationList;
          totalDurationList = _audioPlayer.duration;
          print(totalDurationList);
        // for (var i = 0; i < sequence.length; i++){
        //
        //    snapshot.data.currentIndex.
        //    Duration duration = sequence[i].duration;
        // }

        format(Duration? d) => d?.toString().substring(2, 7) ?? " ";
        return ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: [
            for (var i = 0; i < sequence.length; i++)
        GestureDetector(
          onTap:()=> _audioPlayer.seek(Duration.zero, index: i),

          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2),
              padding: EdgeInsets.only(top: 8, bottom: 8, right: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                        Icon(Icons.play_circle_fill, color: Colors.white)
                        ,
                      ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ((i+1).toString() +
                            '/' +
                            sequence.length.toString() +
                            '  ' +
                            sequence[i].tag.title),
                        maxLines: 1,

                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        // format(_audioPlayer.duration).toString(),
                        // format(sequence.single.duration).toString(),
                        format(sequence[i].duration).toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              )),
        )
          ],
        );
      },
    );
  }
}
