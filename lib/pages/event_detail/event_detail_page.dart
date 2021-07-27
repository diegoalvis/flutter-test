import 'dart:ui';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/event_detail/event_detail_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app_theme.dart';

class EventDetailPage extends StatelessWidget {
  final DataPlacesDetailModel detail;

  EventDetailPage({required this.detail});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventDetailViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return EventDetailWidget(detail);
      },
    );
  }
}

class EventDetailWidget extends StatefulWidget {
  final DataPlacesDetailModel _detail;

  EventDetailWidget(this._detail);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {
  late YoutubePlayerController _controller;
  final _route = locator<IdtRoute>();
  bool conVideo = true;

  @override
  void initState() {

    String? videoId = YoutubePlayer.convertUrlToId(widget._detail.video.toString());
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
    );

    if (widget._detail.video.toString() == '') {
      conVideo = false;
    }

    YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        disableDragSeek: true,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
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
      home: WillPopScope(
        onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            floatingActionButton: IdtFab(),
            bottomNavigationBar: IdtBottomAppBar(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            backgroundColor: IdtColors.white,
            body: _buildEventDetail(viewModel)),
      ),
    );
  }

  Widget _buildEventDetail(EventDetailViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget _btnsPlaces() {
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
                onPressed: () => viewModel.launchMap(widget._detail.location!),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 120,
                child: Text(
                  widget._detail.place ?? 'Localidad del evento',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textButtomWhite.copyWith(fontSize: 16),
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
                  launch("tel:+1 555 010 999");
                  print('LLamando, fallando en la llamada?!!');
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 120,
                child: Text(
                  'tel: ${widget._detail.phone}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textButtomWhite.copyWith(fontSize: 16),
                ),
              ),
            ],
          )
        ],
      );
    }

    Widget _footerImages() {
      return Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true, enlargeCenterPage: true, height: 320, viewportFraction: 0.6),
              items: widget._detail.gallery!
                  .map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              child:
                                  Image.network(IdtConstants.url_image + item, fit: BoxFit.cover)),
                        ),
                      ))
                  .toList()),
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
                onTap: () => viewModel.launchMap(widget._detail.location!),
                child: Container(
                  height: size.width * 0.2,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(180.0)),
                      border: Border.all(color: IdtColors.blueDark.withOpacity(0.8), width: 2),
                      color: IdtColors.white),
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
          ),
        ],
      );
    }

    Widget _body() {
      final String dateEvent =
          DateFormat('yMMMMd', 'es').format(DateTime.parse(widget._detail.date!));
      final viewModel = context.watch<EventDetailViewModel>();

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Text(
                widget._detail.title!,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textTheme.textWhiteShadow.copyWith(fontSize: 35),
              ),
            ),
            Text(
              dateEvent.toUpperCase(),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.textWhiteShadow.copyWith(fontSize: 15),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: conVideo
                    ? Container(
                        height: 200,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              bottomActions: <Widget>[
                                const SizedBox(width: 14.0),
                                CurrentPosition(),
                                const SizedBox(width: 4.0),
                                ProgressBar(isExpanded: true),
                                const SizedBox(width: 4.0),
                                RemainingDuration(),
                                const SizedBox(width: 14.0),
                              ],
                              aspectRatio: 3 / 3,
                              progressIndicatorColor: Colors.red,
                              onReady: () {
                                print('Player is ready.');
                              },
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 100),
                              reverseDuration: Duration(milliseconds: 700),
                              child: _controller.value.isPlaying
                                  ? SizedBox.shrink()
                                  : Container(
                                      color: IdtColors.black.withOpacity(0.5),
                                      child: Center(
                                        child: Icon(
                                          _controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: IdtColors.white,
                                          size: 60.0,
                                        ),
                                      ),
                                    ),
                            ),
                            //_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            GestureDetector(
                              onTap: () {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              },
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
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
              padding: EdgeInsets.symmetric(horizontal: 55),
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                widget._detail.description ??
                    'Esta seccion da informacion relacionada del evento una descripcion al usuario',
                style: textTheme.textButtomWhite,
                maxLines: viewModel.status.moreText ? null : 20,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
              ),
            ),
            TextButton(
              child: Text(viewModel.status.moreText ? 'MOSTRAR MENOS' : 'SEGUIR LEYENDO',
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.textButtomWhite
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: viewModel.readMore,
            )
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            image: NetworkImage(IdtConstants.url_image + widget._detail.coverImage!),
            fit: BoxFit.fitHeight,
          )),
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
                  height: 80,
                )
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: -5,
            left: -15,
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
                    onPressed: _route.pop,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
