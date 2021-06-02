import 'dart:math';
import 'dart:ui';

import 'package:audio_session/audio_session.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/pages/play_audio/play_audio_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/play_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share/share.dart';

import '../../app_theme.dart';

class PlayAudioPage extends StatelessWidget {
  final DataPlacesDetailModel detail;
  PlayAudioPage({required this.detail});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          PlayAudioViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return PlayAudioWidget(detail);
      },
    );
  }
}

class PlayAudioWidget extends StatefulWidget {
  final DataPlacesDetailModel _detail;

  PlayAudioWidget(this._detail);
  double sizeContainer = 0;
  @override
  _PlayAudioWidgetState createState() => _PlayAudioWidgetState();
}

class _PlayAudioWidgetState extends State<PlayAudioWidget>
    with SingleTickerProviderStateMixin {
  final _route = locator<IdtRoute>();
  final List<String> _dropdownValues = ["Español", "Ingles", "Portugués"];
  late AudioPlayer _player;

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      print("widget._detail.audioguia_es!");
      print(widget._detail.url_audioguia_es!);
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          IdtConstants.url_image + '/' + widget._detail.url_audioguia_es!)));
    } catch (e) {
      print("An error occured $e");
    }
  }

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<PlayAudioViewModel>();
    _player = AudioPlayer();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlayAudioViewModel>();
    viewModel.status.urlAudio =
        IdtConstants.url_image + widget._detail.url_audioguia_es!;

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

  Widget _buildPlayAudio(PlayAudioViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget dropdownWidget() {
      return DropdownButton(
        items: _dropdownValues
            .map((value) => DropdownMenuItem(
                  child: Text(value),
                  value: value,
                ))
            .toList(),
        onChanged: viewModel.selectLanguage,
        isExpanded: false,
        value: viewModel.status.language,
        hint: Text('Selecciona'),
      );
    }

    Widget _body() {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              viewModel.status.isFavorite
                  ? IdtIcons.heart2
                  : Icons.favorite_border,
              color:
                  viewModel.status.isFavorite ? IdtColors.red : IdtColors.white,
            ),
            padding: EdgeInsets.only(right: 20.0),
            iconSize: 35,
            onPressed: viewModel.onTapFavorite,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            child: Text(
              widget._detail.title!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.textWhiteShadow.copyWith(fontSize: 25),
            ),
          ),
          OutlineButton(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
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
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              onPressed: () {}),
          SizedBox(
            height: 20,
          ),
          _box(),
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
      ));
    }

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(IdtConstants.url_image + widget._detail.image!),
            fit: BoxFit.fill,
          ),
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
                          padding: EdgeInsets.only(left: 0),
                          child: IconButton(
                            autofocus: false,
                            color: IdtColors.red,
                            alignment: Alignment.centerRight,
                            icon: SvgPicture.asset(
                              IdtAssets.back_white,
                              color: IdtColors.white,
                              height: 70.0,
                            ),
                            iconSize: 60,
                            onPressed: _route.pop,
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
                              Share.share(
                                  "Visita la página oficial de turismo de Bogotá https://bogotadc.travel/");
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
        ));
  }

  Column _box() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          // padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: IdtColors.black.withOpacity(0.5),
            shape: BoxShape.rectangle,
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              SizedBox(
                                child: ButtonPlayPause(_player, Colors.yellow),
                              ),
                              Container(
                                child: new LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  print("--- ${MediaQuery.of(context).size}");
                                  print(
                                      "+++ ${(MediaQuery.of(context).size.width / 1.58)}");
                                  widget.sizeContainer =
                                      MediaQuery.of(context).size.width / 1.58;
                                  return Container(
                                    child: AnimatedContainerApp(
                                        widget.sizeContainer,
                                        Colors.blue,
                                        IdtAssets.waves),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    height: 80,
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          child: Row(
                            children: [
                              SizedBox(
                                child: ButtonPlayPause(_player, Colors.yellow),
                              ),
                              Container(
                                child: new LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  print("--- ${MediaQuery.of(context).size}");
                                  print(
                                      "+++ ${(MediaQuery.of(context).size.width / 1.58)}");
                                  widget.sizeContainer =
                                      MediaQuery.of(context).size.width / 1.58;
                                  return Container(
                                    child: PositionDuration(
                                      AnimatedContainerApp(
                                        widget.sizeContainer,
                                        Colors.greenAccent,
                                        IdtAssets.waves_front,
                                      ),
                                      widget.sizeContainer,
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 65,
                    height: 80,
                    child: Container(
                      // color: Colors.red.withOpacity(0.5),
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      height: 80,

                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: BarPosition(widget.sizeContainer),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextDuration(widget.sizeContainer),
            ],
          ),
        ),
      ],
    );
  }

  Container _boxOriginal() {
    return Container(
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
                child: ButtonPlayPause(_player, Colors.red),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 10,
                child: AnimatedSize(
                  reverseDuration: Duration(seconds: 100),
                  curve: Curves.linear,
                  duration: Duration(seconds: 140),
                  vsync: this,
                  child: Image(
                    height: 50,
                    //width: 200,
                    color: IdtColors.orange,
                    image: AssetImage(IdtAssets.waves),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      /*child: viewModel.status.isOnline ?
              PlayerWidget(url: IdtConstants.audio) : PlayerWidget(url: viewModel.status.pathAudio)*/
    );
  }

  PositionDuration(
    Widget child,
    double width,
  ) {
    return StreamBuilder<Duration?>(
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
                final pos = snapshot.data?.position.inSeconds ?? 0;
                final total = duration.inSeconds;
                final widthPosition = (pos * width) / total;

                return AnimatedContainerApp(
                  widthPosition,
                  Colors.orange,
                  IdtAssets.waves_front,
                );
              });
        });
  }

  BarPosition(
    double width,
  ) {
    return StreamBuilder<Duration?>(
      stream: _player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        return StreamBuilder<PositionData>(
          stream: Rx.combineLatest2<Duration, Duration, PositionData>(
            _player.positionStream,
            _player.bufferedPositionStream,
            (position, bufferedPosition) => PositionData(
              position,
              bufferedPosition,
            ),
          ),
          builder: (context, snapshot) {
            final positionData =
                snapshot.data ?? PositionData(Duration.zero, Duration.zero);
            var position = positionData.position;
            if (position > duration) {
              position = duration;
            }
            var bufferedPosition = positionData.bufferedPosition;
            if (bufferedPosition > duration) {
              bufferedPosition = duration;
            }
            return SeekBar(
              duration: duration,
              position: position,
              bufferedPosition: bufferedPosition,
              onChangeEnd: (newPosition) {
                _player.seek(newPosition);
              },
              width: widget.sizeContainer,
            );
          },
        );
      },
    );
  }

  TextDuration(double width) {
    return StreamBuilder<Duration?>(
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
            final positionData =
                snapshot.data ?? PositionData(Duration.zero, Duration.zero);
            var position = positionData.position;
            if (position > duration) {
              position = duration;
            }
            var bufferedPosition = positionData.bufferedPosition;
            if (bufferedPosition > duration) {
              bufferedPosition = duration;
            }
            return Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("${duration - position}")
                      ?.group(1) ??
                  '${duration - position}',
              style: Theme.of(context)
                  .textTheme
                  .textButtomWhite
                  .copyWith(fontSize: 20),
            );
          },
        );
      },
    );
  }
}

class WaveAnimated extends StatefulWidget {
  const WaveAnimated(this._color, this._seconds1, this._seconds2) : super();
  final int _seconds1;
  final int _seconds2;
  final Color _color;

  @override
  _WaveAnimatedState createState() => _WaveAnimatedState();
}

class _WaveAnimatedState extends State<WaveAnimated>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      reverseDuration: Duration(seconds: widget._seconds1),
      curve: Curves.linear,
      duration: Duration(seconds: widget._seconds2),
      vsync: this,
      child: Image(
        height: 50,
        //width: 200,
        color: widget._color,
        image: AssetImage(IdtAssets.waves),
        fit: BoxFit.fill,
      ),
    );
  }
}

class ButtonPlayPause extends StatefulWidget {
  const ButtonPlayPause(
    this._player,
    this.color,
  );

  final AudioPlayer _player;
  final Color color;

  @override
  _ButtonPlayPauseState createState() => _ButtonPlayPauseState();
}

class _ButtonPlayPauseState extends State<ButtonPlayPause> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: widget._player.playerStateStream,
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
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
          );
        } else if (playing != true) {
          return IconButton(
            icon: Icon(Icons.play_arrow, color: IdtColors.white),
            iconSize: 64.0,
            onPressed: widget._player.play,
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(Icons.pause, color: IdtColors.white),
            iconSize: 64.0,
            onPressed: widget._player.pause,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.replay, color: IdtColors.white),
            iconSize: 50.0,
            onPressed: () => widget._player.seek(Duration.zero,
                index: widget._player.effectiveIndices!.first),
          );
        }
      },
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
  final double width;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    required this.width,
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      width: widget.width * 1.1,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          SliderTheme(
            data: _sliderThemeData.copyWith(
              thumbShape: HiddenThumbComponentShape(),
              activeTrackColor: IdtColors.white,
              inactiveTrackColor: IdtColors.transparent,
              thumbColor: IdtColors.transparent,
              overlayColor: IdtColors.transparent,
              activeTickMarkColor: IdtColors.transparent,
              disabledActiveTickMarkColor: IdtColors.transparent,
              inactiveTickMarkColor: IdtColors.transparent,
              valueIndicatorColor: IdtColors.transparent,
              overlappingShapeStrokeColor: IdtColors.transparent,
              disabledActiveTrackColor: Colors.transparent,
              disabledThumbColor: Colors.transparent,
              disabledInactiveTrackColor: Colors.transparent,
              disabledInactiveTickMarkColor: Colors.transparent,
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
                activeColor: IdtColors.transparent,
                inactiveColor: IdtColors.transparent,
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
              trackHeight: 40,
              activeTrackColor: IdtColors.white,
              thumbColor: IdtColors.transparent,
              overlayColor: IdtColors.transparent,
              activeTickMarkColor: IdtColors.transparent,
              disabledActiveTickMarkColor: IdtColors.transparent,
              inactiveTickMarkColor: IdtColors.transparent,
              valueIndicatorColor: IdtColors.transparent,
              overlappingShapeStrokeColor: IdtColors.transparent,
              disabledActiveTrackColor: Colors.transparent,
              disabledThumbColor: Colors.transparent,
              disabledInactiveTrackColor: Colors.transparent,
              disabledInactiveTickMarkColor: Colors.transparent,
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                  _dragValue ?? widget.position.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble()),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              activeColor: IdtColors.transparent,
              inactiveColor: IdtColors.transparent,
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();

  AnimatedContainerApp(
    double _width,
    Color _color,
    String _wavePng,
  ) {
    this._width = _width;
    this._color = _color;
    this._wavePng = _wavePng;
  }

  late double _width;
  late Color _color;
  late String _wavePng;
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.

  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    print(double.infinity);
    return Padding(
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: widget._width,
        height: 40,

        decoration: BoxDecoration(
          // color: Colors.yellow.withOpacity(0.5),
          borderRadius: _borderRadius,
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            alignment: Alignment.bottomLeft,
            scale: 1,
            image: AssetImage(
              widget._wavePng,
            ),
          ),
        ),
        // Define how long the animation should take.
        duration: Duration(milliseconds: 400),
        // Provide an optional curve to make the animation feel smoother.
      ),
    );
  }
}
