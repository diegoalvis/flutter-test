import 'dart:math';
import 'dart:ui';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/play_audio/play_audio_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:audio_session/audio_session.dart';
import 'package:bogota_app/widget/play_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_theme.dart';

class PlayAudioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => PlayAudioViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor

>()
      ),
      builder: (context, _) {
        return PlayAudioWidget();
      },
    );
  }
}

class PlayAudioWidget extends StatefulWidget {

  @override
  _PlayAudioWidgetState createState() => _PlayAudioWidgetState();
}

class _PlayAudioWidgetState extends State<PlayAudioWidget> {

  final List<String> _dropdownValues = [
    "Español",
    "Ingles"
  ];
  late AudioPlayer _player;

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(IdtConstants.audio)));
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }
  /*AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();*/

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();

    /*if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }*/
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<PlayAudioViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: IdtBottomAppBar(),
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: IdtColors.white,
        body: _buildPlayAudio(viewModel)
      ),
    );
  }


  Widget _buildPlayAudio(PlayAudioViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget dropdownWidget() {
      return DropdownButton(

        items: _dropdownValues.map((value) => DropdownMenuItem(
          child: Text(value),
          value: value,
        )).toList(),
        onChanged: viewModel.selectLanguage,
        isExpanded: false,
        value: viewModel.status.language,
        hint: Text('Selecciona'),

      );
    }

    Widget _body (){

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                viewModel.status.isFavorite ? IdtIcons.heart2 : Icons.favorite_border,
                color: viewModel.status.isFavorite ? IdtColors.red : IdtColors.white,
              ),
              padding: EdgeInsets.only(right: 20.0),
              iconSize: 35,
              onPressed: viewModel.onTapFavorite,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Text(
                'PARQUE METROPOLITANO SIMÓN BOLIVAR',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textTheme.textWhiteShadow.copyWith(
                  fontSize: 25
                ),
              ),
            ),
            // dropdownWidget(),
            OutlineButton(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: IdtColors.black.withOpacity(0.6),
                  shape: BoxShape.rectangle,
                ),
                child: DropdownButton(

                  items: _dropdownValues.map((value) => DropdownMenuItem(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: textTheme.textButtomWhite,
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: false,
                  iconSize: 30,
                  underline: SizedBox.shrink(),
                  value: viewModel.status.language,
                  iconEnabledColor: IdtColors.white,
                  dropdownColor: IdtColors.black.withOpacity(0.95),
                  style: textTheme.titleGray,
                  hint: Text('Selecciona'),
                  onChanged: viewModel.selectLanguage,
                ),
              ),
              padding: EdgeInsets.all(0),
              borderSide: BorderSide(color: IdtColors.white, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              onPressed: (){}
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: IdtColors.black.withOpacity(0.5),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                          child: StreamBuilder<PlayerState>(
                            stream: _player.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState = playerState?.processingState;
                              final playing = playerState?.playing;
                              if (processingState == ProcessingState.loading ||
                                  processingState == ProcessingState.buffering) {
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(IdtColors.orange)
                                  ),
                                );
                              } else if (playing != true) {
                                return IconButton(
                                  icon: Icon(Icons.play_arrow, color: IdtColors.white),
                                  iconSize: 64.0,
                                  onPressed: _player.play,
                                );
                              } else if (processingState != ProcessingState.completed) {
                                return IconButton(
                                  icon: Icon(Icons.pause, color: IdtColors.white),
                                  iconSize: 64.0,
                                  onPressed: _player.pause,
                                );
                              } else {
                                return IconButton(
                                  icon: Icon(Icons.replay, color: IdtColors.white),
                                  iconSize: 50.0,
                                  onPressed: () => _player.seek(Duration.zero,
                                    index: _player.effectiveIndices!.first),
                                );
                              }
                            },
                          )
                        /*child: IconButton(
                          key: Key('play_button'),
                          iconSize: 70.0,
                          icon: processingState != ProcessingState.completed ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                          color: IdtColors.white,
                          onPressed: _player.play,
                        ),*/
                      ),
                      Flexible(
                        flex: 10,
                        child: Image(
                          image: AssetImage(IdtAssets.waves),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  StreamBuilder<Duration?>(
                    stream: _player.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      return StreamBuilder<PositionData>(
                        stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                            _player.positionStream,
                            _player.bufferedPositionStream,
                                (position, bufferedPosition) =>
                                PositionData(position, bufferedPosition)),
                        builder: (context, snapshot) {
                          final positionData = snapshot.data ??
                              PositionData(Duration.zero, Duration.zero);
                          var position = positionData.position;
                          if (position > duration) {
                            position = duration;
                          }
                          var bufferedPosition = positionData.bufferedPosition;
                          if (bufferedPosition > duration) {
                            bufferedPosition = duration;
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                                  .firstMatch("${duration - position}")
                                  ?.group(1) ??
                                  '${duration - position}',
                                style: Theme.of(context).textTheme.textButtomWhite.copyWith(
                                  fontSize: 20
                                )
                              ),
                              SeekBar(
                                duration: duration,
                                position: position,
                                bufferedPosition: bufferedPosition,
                                onChangeEnd: (newPosition) {
                                  _player.seek(newPosition);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              /*child: viewModel.status.isOnline ?
                PlayerWidget(url: IdtConstants.audio) : PlayerWidget(url: viewModel.status.pathAudio)*/
            ),
            SizedBox(height: 12),
            FlutterSwitch(
              value: viewModel.status.modeOffline,
              activeColor: IdtColors.white,
              activeToggleColor: IdtColors.orange,
              inactiveColor: IdtColors.white,
              inactiveToggleColor: IdtColors.grayBtn,
              padding: 3,
              height: 30,
              onToggle: viewModel.changeModeOffline,
            ),
            SizedBox(height: 8),
            Text(
              'Modo Offline',
              style: textTheme.textButtomWhite,
            )
          ],
        )
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            IdtAssets.splash
          ),
          fit: BoxFit.cover,
        )
      ),
      height: size.height,
      width: size.width,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              right: 0,
              left: 0,
              child: Container(
                color: IdtColors.transparent,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      color: IdtColors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: IconButton(
                          autofocus: false,
                          color: IdtColors.red,
                          alignment: Alignment.centerRight,
                          icon: SvgPicture.asset(
                            IdtAssets.back,
                            color: IdtColors.white,
                            height: 50.0,
                          ),
                          onPressed: () {
                            print("Favorite");
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: IconButton(
                          autofocus: false,
                          color: IdtColors.transparent,
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.share,
                            color: IdtColors.white,
                            size: 40.0,
                          ),
                          onPressed: () {
                            print("Share");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _body(),
                SizedBox(
                  height: 55,
                )
              ],
            )
          ],
        ),
      )
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}


class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: IdtColors.white,
            inactiveTrackColor: IdtColors.grayBtn,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            activeColor: IdtColors.orange,
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        /*Positioned(
          left: 15.0,
          top: 0.0,
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.textButtomWhite.copyWith(
                fontSize: 16
              )),
          ),
        ),*/
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}
