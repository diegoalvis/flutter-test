import 'dart:ui';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/event_detail/event_detail_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../app_theme.dart';

class EventDetailPage extends StatelessWidget {

  EventDetailPage();

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => EventDetailViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return EventDetailWidget();
      },
    );
  }
}

class EventDetailWidget extends StatefulWidget {

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<EventDetailViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: IdtFab(),
        bottomNavigationBar: IdtBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: IdtColors.white,
        body: _buildEventDetail(viewModel)
      ),
    );
  }

  Widget _buildEventDetail(EventDetailViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget _btnsPlaces(){

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(
                  IdtIcons.mappin,
                  color: IdtColors.white,
                  size: 50,
                ),
                onPressed: () {
                  print('Location');
                },
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'Parque Simón Bolivar',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textButtomWhite.copyWith(
                    fontSize: 16
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.phone,
                  color: IdtColors.white,
                  size: 50,
                ),
                onPressed: () {

                },
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'tel: +573133333',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textButtomWhite.copyWith(
                    fontSize: 16
                  ),
                ),
              )
            ],
          )
        ],
      );
    };

    Widget _footerImages(){

      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              height: 320,
              viewportFraction: 0.6
            ),
            items: DataTest.imgList2.map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  child: Image.network(
                    item,
                    fit: BoxFit.cover
                  )
                ),
              ),
            )).toList()
          ),
          SizedBox(height: 25),
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Image(
                  image: AssetImage(IdtAssets.map),
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                onTap: viewModel.launchMap,
                child: Container(
                  height: size.width * 0.2,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(180.0)),
                    border: Border.all(
                      color: IdtColors.blueDark.withOpacity(0.8),
                      width: 2
                    ),
                    color: IdtColors.white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Icon(
                        Icons.search,
                        color: IdtColors.blueDark.withOpacity(0.8),
                        size: 28,
                      ),
                      Text(
                        '¿CÓMO LLEGAR?',
                        textAlign: TextAlign.center,
                        style: textTheme.textButtomBlue.copyWith(
                          fontSize: 12,
                          color: IdtColors.blueDark.withOpacity(0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      );
    }

    Widget _body (){

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Text(
                'ROCK AL PARQUE',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textTheme.textWhiteShadow.copyWith(
                  fontSize: 35
                ),
              ),
            ),
            Text(
              'Julio 14, 15 y 16 de 2021'.toUpperCase(),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.textWhiteShadow.copyWith(
                fontSize: 15
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 220,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    ClosedCaption(text: _controller.value.caption.text),
                    Stack(
                      children: <Widget>[
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 100),
                          reverseDuration: Duration(milliseconds: 700),
                          child: _controller.value.isPlaying
                            ? SizedBox.shrink()
                            : Container(
                              color: IdtColors.black.withOpacity(0.5),
                              child: Center(
                                child: Icon(
                                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: IdtColors.white,
                                  size: 100.0,
                                ),
                              ),
                            ),
                        ),
                        //_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        GestureDetector(
                          onTap: () {
                            _controller.value.isPlaying ? _controller.pause() : _controller.play();
                          },
                        ),
                      ],
                    ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            _btnsPlaces(),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                'Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,',
                style: textTheme.textButtomWhite,
                maxLines: viewModel.status.moreText ? null : 20,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
              ),
            ),
            TextButton(
              child: Text(
                viewModel.status.moreText ? 'MOSTRAR MENOS' : 'SEGUIR LEYENDO',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textTheme.textButtomWhite.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              onPressed: viewModel.readMore,
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
          fit: BoxFit.fitHeight,
        )
      ),
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 65,
                ),
                _body(),
                SizedBox(
                  height: 30,
                ),
                _footerImages(),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 14),
                  child: IconButton(
                    autofocus: false,
                    alignment: Alignment.centerRight,
                    icon: SvgPicture.asset(
                      IdtAssets.back,
                      color: IdtColors.white,
                    ),
                    iconSize: 45,
                    onPressed: () {
                      print("Back Button");
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    viewModel.status.isFavorite ? IdtIcons.heart2 : Icons.favorite_border,
                    color: viewModel.status.isFavorite ? IdtColors.red : IdtColors.white,
                  ),
                  padding: EdgeInsets.only(right: 20.0),
                  iconSize: 35,
                  onPressed: viewModel.onTapFavorite,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

