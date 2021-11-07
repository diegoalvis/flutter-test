import 'dart:async';
import 'dart:ui';

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/audios_model.dart';
import 'package:bogota_app/data/model/language_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/mock/data/testData.dart';
import 'package:bogota_app/pages/play_audio/play_audio_effect.dart';
import 'package:bogota_app/pages/play_audio/play_audio_page.dart';

import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/audio_payer/button_player.dart';
import 'package:bogota_app/widget/audio_payer/player_buttons.dart';
import 'package:bogota_app/widget/audio_payer/playlist.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';

//import 'package:googleapis/vision/v1.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import 'play_audio_guia_view_model.dart';

import 'package:just_audio/just_audio.dart';

class PlayAudioGuiaPage extends StatelessWidget {
  final AudiosModel detail;

  PlayAudioGuiaPage({required this.detail});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayAudioGuiaViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return PlayAudioGuiaWidget(detail!);
      },
    );
  }
}

class PlayAudioGuiaWidget extends StatefulWidget {
  final AudiosModel _detail;

  PlayAudioGuiaWidget(this._detail);

  double sizeContainer = 0;

  @override
  _PlayAudioGuiaWidgetState createState() => _PlayAudioGuiaWidgetState();
}

class _PlayAudioGuiaWidgetState extends State<PlayAudioGuiaWidget> with SingleTickerProviderStateMixin {
  bool offlineMode = false; //pasar al viewModel
  final _route = locator<IdtRoute>();
  final List<String> _dropdownValues = ['Español', 'Ingles', 'Portugües']; //obtener por servicio

  List<AudioSource> audiosService = [];
  List audiosPlayList = [];

  // late AudioPlayer _audioPlayer = AudioPlayer();
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    for (var i = 0; i < widget._detail.audios!.length; i++) {
      audiosService.add(AudioSource.uri(
        Uri.parse(IdtConstants.url_image + widget._detail.audios![i]),
        tag: AudioMetadata(
          title: widget._detail.title!,
        ),
      ));
    }
    print(audiosService);
    print('ok');

    _audioPlayer
        .setAudioSource(
      ConcatenatingAudioSource(
        children: audiosService, //Lista de Datos Audio
      ),
    )
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
    Duration? totalDurationList = _audioPlayer.duration;
    print(totalDurationList);
    // _audioPlayer.setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: [
    //       AudioSource.uri(
    //         Uri.parse(
    //             IdtConstants.url_image + widget._detail.audios![0].toString()
    //             // "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3"
    //         ),
    //         tag: AudioMetadata(
    //           title: "Tristram",
    //           artwork:
    //               "https://upload.wikimedia.org/wikipedia/en/3/3a/Diablo_Coverart.png",
    //         ),
    //       ),
    //       AudioSource.uri(
    //         Uri.parse(
    //             IdtConstants.url_image + widget._detail.audios![1].toString()),
    //         tag: AudioMetadata(
    //           title: "Cerulean City",
    //           artwork:
    //               "https://upload.wikimedia.org/wikipedia/en/f/f1/Bulbasaur_pokemon_red.png",
    //         ),
    //       ),
    //       AudioSource.uri(
    //         Uri.parse(
    //             IdtConstants.url_image + widget._detail.audios![2].toString()),
    //         tag: AudioMetadata(
    //           title: "The secret of Monkey Island - Introduction",
    //           artwork:
    //               "https://upload.wikimedia.org/wikipedia/en/a/a8/The_Secret_of_Monkey_Island_artwork.jpg",
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  int selectedPosition = -1;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlayAudioGuiaViewModel>();
    print("widget._detail");
    print(widget._detail.title);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: IdtBottomAppBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: IdtColors.white,
        body: _buildPlayAudio(viewModel),
      ),
    );
  }

  Widget _buildPlayAudio(PlayAudioGuiaViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;

    Widget _body() {
      final List dummyList = List.generate(10, (index) {
        return {"id": index, "title": "This is the title $index", "subtitle": "This is the subtitle $index"};
      });
      return Container(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        IdtAssets.back_white,
                        color: IdtColors.white,
                      ),
                      iconSize: 52,
                      padding: EdgeInsets.only(left: 10, bottom: 4),
                      alignment: Alignment.bottomCenter,
                      onPressed: _route.pop,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: IdtColors.white,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        color: IdtColors.black.withOpacity(0.6),
                        shape: BoxShape.rectangle,
                      ),
                      child: DropdownButton(
                        items: _dropdownValues
                            .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: textTheme.textButtomWhite,
                                  ),
                                  value: value,
                                ))
                            .toList(),
                        isExpanded: false,
                        iconSize: 30,
                        value: viewModel.status.language,
                        iconEnabledColor: Colors.white,
                        dropdownColor: IdtColors.black.withOpacity(0.4),
                        style: textTheme.titleGray,
                        hint: Text('Español'),
                        onChanged: viewModel.selectLanguage,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Text(
                  widget._detail.title!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textWhiteShadow.copyWith(fontSize: 25),
                ),
              ),
              Text(
                widget._detail.audios!.length.toString() + ' Pista(s) de audio',
                style: textTheme.textWhiteShadow.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '34:55 minutos ',
                style: textTheme.textWhiteShadow.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              IconButton(
                  icon: Icon(
                    viewModel.status.isFavorite ? IdtIcons.heart2 : Icons.favorite_border,
                    color: viewModel.status.isFavorite ? IdtColors.red : IdtColors.white,
                  ),
                  iconSize: 35,
                  onPressed: BoxDataSesion.isLoggedIn
                      ? viewModel.onTapFavorite
                      : () {
                          viewModel.dialogSuggestionLoginSavedPlace();
                        }),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  IdtConstants.url_image + widget._detail.main_img!,
                  fit: BoxFit.cover,
                  height: sizeScreen.width * 0.5,
                  width: sizeScreen.width * 0.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 12),
              FlutterSwitch(
                // value: viewModel.status.modeOffline,
                value: offlineMode,
                activeColor: IdtColors.blueAccent,
                activeToggleColor: IdtColors.white,
                inactiveColor: IdtColors.white,
                inactiveToggleColor: IdtColors.grayBtn,
                padding: 3,
                height: 30,
                onToggle: (bool value) {
                  setState(() {
                    offlineMode = value;
                  });
                },
              ),
              SizedBox(height: 8),
              Playlist(_audioPlayer, (index) {
                setState(() {
                  selectedPosition = index;
                });
                _audioPlayer.seek(Duration.zero, index: index);
              }, selectedIndex: selectedPosition),
              Text(
                'Modo Offline',
                style: textTheme.textButtomWhite,
              ),
              PlayerButtons(_audioPlayer),
              Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 35, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    //ondas de audio del reproductor.
                    children: [
                      Text(
                        widget._detail.title!,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                        if (MediaQuery.of(context).size.width < 390) {
                          widget.sizeContainer = MediaQuery.of(context).size.width / 2;
                        } else {
                          widget.sizeContainer = MediaQuery.of(context).size.width / 1.65;
                        }
                        return Stack(
                          children: [
                            ImageAnimatedContainer(width: widget.sizeContainer, imagePath: IdtAssets.waves),
                            StreamBuilder<Duration>(
                                stream: _audioPlayer.positionStream,
                                builder: (context, snapshot) {
                                  format(Duration? d) => d?.toString().substring(2, 7) ?? " ";
                                  final currentPosition = snapshot.data?.inSeconds ?? 0;
                                  final totalDuration = _audioPlayer.duration?.inSeconds ?? 1;
                                  final timeCurrent = format(snapshot.data);
                                  final totalTime = format(_audioPlayer.duration);
                                  final progresAudio = currentPosition / totalDuration; //es un %
                                  final widthAudio = widget.sizeContainer * (currentPosition / totalDuration);
                                  return IntrinsicWidth(
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            ImageAnimatedContainer(
                                                width: widthAudio, imagePath: IdtAssets.waves_front),
                                            Container(
                                              width: widget.sizeContainer,
                                              child: SliderTheme(
                                                data: SliderTheme.of(context).copyWith(
                                                  trackShape: CustomSliderTrackShape(),
                                                  trackHeight: 0.0,
                                                  thumbShape: RoundSliderThumbShape(
                                                    enabledThumbRadius: 0,
                                                  ),
                                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                                                ),
                                                child: Slider(
                                                    min: 0.0,
                                                    max: totalDuration.toDouble(),
                                                    value: currentPosition.toDouble(),
                                                    onChanged: (pos) {
                                                      _audioPlayer.seek(Duration(seconds: pos.toInt()));
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              timeCurrent,
                                              style: TextStyle(color: IdtColors.white, fontSize: 10),
                                            ),
                                            Spacer(),
                                            Text(totalTime,
                                                style: TextStyle(color: IdtColors.white, fontSize: 10)),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      }),
                    ],
                  )),
              SizedBox(
                height: 100,
              )
              // Playlist(_audioPlayer),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: sizeScreen.height,
          width: sizeScreen.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(IdtConstants.url_image + widget._detail.main_img!),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        _body()
      ],
    );
  }

  Widget PlayListB(AudioPlayer _audioPlayer) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: audiosPlayList.length,
        itemBuilder: (BuildContext context, int index) {
          // final data = json.encode(audiosPlayList[index]);
          // Map<String, dynamic> datos = jsonDecode(data.toString());

          print(IdtConstants.url_image + audiosPlayList[index]['audio']);
          audiosService.add(AudioSource.uri(
            Uri.parse(IdtConstants.url_image + audiosPlayList[index]['audio']),
          ));

          format(Duration? d) => d?.toString().substring(2, 7) ?? " ";

          return Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 1, right: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                          color: IdtColors.red,
                          height: 42,
                          alignment: Alignment.centerLeft,
                          child: ButtonPlayer(_audioPlayer, index)

                          // child: index == 2
                          //     ? Icon(Icons.pause_circle_filled_sharp,color: Colors.white,size: 45,)
                          //     :Icon(Icons.play_circle_fill ,color: Colors.white)
                          ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 160,
                        child: AutoSizeText(
                          (audiosPlayList[index]['part'].toString() +
                              '/' +
                              audiosPlayList.length.toString() +
                              '  ' +
                              audiosPlayList[index]['title']),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          minFontSize: 11,
                          maxFontSize: 12,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 58),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      format(_audioPlayer.duration).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ));
        });
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class AudioMetadata {
  /// The name of the song/show/recording.
  final String title;

  /// URL to an image representing this audio source.
  // final String artwork;

  // TODO change placeholder
  AudioMetadata({
    required this.title,
    // this.artwork = 'https://via.placeholder.com/150'
  });
}
