import 'dart:ui';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/play_audio/play_audio_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class PlayAudioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => PlayAudioViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
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

  /*final List<String> _dropdownValues = [
    "MultiWaveVisualizer",
    "LineVisualizer",
    "LineBarVisualizer",
    "CircularLineVisualizer",
    "CircularBarVisualizer",
    "BarVisualizer"
  ];

  Widget dropdownWidget() {
    return DropdownButton(
      //map each value from the lIst to our dropdownMenuItem widget
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
        child: Text(value),
        value: value,
      ))
          .toList(),
      onChanged: (String value) {
        setState(() {
          selected = value;
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: newValue,
      hint: Text('choose'),

    );
  }*/
  /*AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();*/

  @override
  void initState() {
    super.initState();

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

    Widget _body (){

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              autofocus: false,
              color: IdtColors.red,
              alignment: Alignment.center,
              icon: Icon(
                IdtIcons.heart2,
                color: IdtColors.red,
                size: 30.0,
              ),
              onPressed: () {
                print("Corazon");
              },
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
            OutlineButton(
              child: Container(
                //color: IdtColors.black,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: IdtColors.black.withOpacity(0.6),
                  shape: BoxShape.rectangle,
                  /*borderSide: BorderSide(color: IdtColors.white, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),*/
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Español',
                      textAlign: TextAlign.center,
                      style: textTheme.textButtomWhite,
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: IdtColors.white,
                      size: 30,
                    ),
                  ],
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: IdtColors.black.withOpacity(0.4),
                shape: BoxShape.rectangle,
              ),
              /*child: viewModel.status.isOnline ?
                PlayerWidget(url: IdtConstants.audio) : PlayerWidget(url: viewModel.status.pathAudio)*/
            ),
            //viewModel.status.isOnline ? Text(viewModel.status.pathAudio, style: textTheme.textButtomWhite) : SizedBox.shrink(),
            /*Switch(
              value: false,
              activeColor: IdtColors.orange,
              inactiveThumbColor: IdtColors.grayBtn,
              inactiveTrackColor: IdtColors.white,
              onChanged: (value){}
            ),*/
            SizedBox(height: 12),
            FlutterSwitch(
              value: viewModel.status.modeOffline,
              onToggle: viewModel.changeModeOffline,
              activeColor: IdtColors.orange,
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
