import 'dart:async';
import 'dart:ui';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/detail/detail_effect.dart';
import 'package:bogota_app/pages/detail/detail_view_model.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class DetailPage extends StatelessWidget {
  final bool isHotel;

  DetailPage({this.isHotel = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DetailViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return DetailWidget(isHotel);
      },
    );
  }
}

class DetailWidget extends StatefulWidget {
  final bool _isHotel;

  DetailWidget(this._isHotel);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  final scrollController = ScrollController();
  StreamSubscription<DetailEffect>? _effectSubscription;

  @override
  void initState() {
    final viewModel = context.read<DetailViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is DetailControllerScrollEffect) {
        scrollController.animateTo(
            event.next
                ? scrollController.offset + event.width
                : scrollController.offset - event.width,
            curve: Curves.linear,
            duration: Duration(milliseconds: event.duration));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: IdtBottomAppBar(),
          extendBody: true,
          extendBodyBehindAppBar: true,
          floatingActionButton: IdtFab(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: IdtColors.white,
          body: _buildDiscover(viewModel)),
    );
  }

  Widget _buildDiscover(DetailViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final _route = locator<IdtRoute>();

    Widget _header() {
      return Stack(
        children: [
          Column(
            children: [
              Image(   //imagen de fondo
                image: AssetImage(IdtAssets.splash),
                width: size.width,
                height: size.height * 0.5,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Positioned(   // curva
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                child: SvgPicture.asset(IdtAssets.curve_up,
                    color: IdtColors.white, fit: BoxFit.fill,),
              ),),
          Positioned(  // rating Starts
            bottom: 100,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar(
                        initialRating: 3.3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        ratingWidget: RatingWidget(
                          full: Icon(IdtIcons.star, color: IdtColors.amber),
                          half: Icon(IdtIcons.star_half_alt,
                              color: IdtColors.amber),
                          empty:
                              Icon(IdtIcons.star_empty,
                                color: IdtColors.amber),
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '3.3/5',
                        style: textTheme.textWhiteShadow.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    'PARQUE METROPOLITANO SIMÓN BOLIVAR',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.textWhiteShadow.copyWith(fontSize: 22),
                  ),
                )
              ],
            ),
          ),
          Positioned(  // app_bar row
            top: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: size.width * 1 / 2,
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: SvgPicture.asset(
                      IdtAssets.back_white,
                      color: IdtColors.white,
                    ),
                    iconSize: 50,
                    onPressed: _route.pop,
                  ),
                ),
                Container(
                  width: size.width * 1 / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.share,
                            color: IdtColors.white,
                          ),
                          iconSize: 35,
                          onPressed: () {
                            print("Share");
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            viewModel.status.isFavorite
                                ? IdtIcons.heart2
                                : Icons.favorite_border,
                            color: viewModel.status.isFavorite
                                ? IdtColors.red
                                : IdtColors.white,
                          ),
                          iconSize: 30,
                          onPressed: viewModel.onTapFavorite,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    Widget _footerImages(DetailViewModel viewModel) {
      return Stack(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(  //carrusel imagenes
                  margin: EdgeInsets.only(bottom: 0, top: 3),
                  width: size.width,
                  height: size.height * 0.5,
                  color: IdtColors.white,
                  child: ListView.builder(
                    itemCount: DataTest.imgList2.length,
                    shrinkWrap: true,
                    itemExtent: MediaQuery.of(context).size.width,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        Image.network(
                          DataTest.imgList2[index],
                          width: size.width,
                          height: size.height * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  )),
              Positioned(
                left: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: IconButton(
                    iconSize: 45,
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: IdtColors.white,
                    ),
                    onPressed: () =>
                        viewModel.onChangeScrollController(false, size.width),
                  ),
                ),
              ),
              Positioned(  //flecha derecha
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: IconButton(
                    iconSize: 45,
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: IdtColors.white,
                    ),
                    onPressed: () =>
                        viewModel.onChangeScrollController(true, size.width),
                  ),
                ),
              ),
            ],
          ),
          Positioned(  //Curva de abajo
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(IdtAssets.curve_down,
                      color: Colors.white, fit: BoxFit.fill))),
        ],
      );
    }

    Widget _btnsPlaces() {
      return Row(  // row botonoes ubicacion y audio
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.orange, width: 1),
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Container(
                constraints: BoxConstraints(maxWidth: 100.0, maxHeight: 55),
                decoration: StylesMethodsApp().decorarStyle(IdtGradients.orange,
                    30, Alignment.bottomRight, Alignment.topLeft),
                alignment: Alignment.center,
                child: Icon(
                  IdtIcons.mappin,
                  color: IdtColors.white,
                  size: 45,
                )),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.blue, width: 1),
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Container(
                constraints: BoxConstraints(maxWidth: 100.0, maxHeight: 55),
                decoration: StylesMethodsApp().decorarStyle(
                    IdtGradients.blueDark,
                    30,
                    Alignment.bottomLeft,
                    Alignment.topRight),
                alignment: Alignment.center,
                child: Icon(
                  IdtIcons.headphones,
                  color: IdtColors.white,
                  size: 40,
                )),
            onPressed: viewModel.goPlayAudioPage,
          )
        ],
      );
    }

    Widget _btnGradient(IconData icon, Color color, List<Color> listColors) {
      //Columna de botonoes para los hoteles
      return RaisedButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: color, width: 1),
            borderRadius: BorderRadius.circular(17.0)),
        padding: EdgeInsets.all(0),
        child: Container(
            width: size.width * 0.7,
            decoration: StylesMethodsApp().decorarStyle(
                listColors, 17, Alignment.bottomCenter, Alignment.topCenter),
            padding: EdgeInsets.symmetric(vertical: 7),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(
                    icon,
                    color: IdtColors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    'Carrera 2 Este No. 1',
                    style: textTheme.textButtomWhite,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
        onPressed: () {},
      );
    }

    Widget _btnsHotel() {  //Column botones en hoteles
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btnGradient(IdtIcons.mappin, IdtColors.orange, IdtGradients.orange),
          SizedBox(
            height: 5,
          ),
          _btnGradient(Icons.phone, IdtColors.green, IdtGradients.green),
          SizedBox(
            height: 5,
          ),
          _btnGradient(Icons.wifi_tethering_sharp, IdtColors.blueDark,
              IdtGradients.blueDark),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Container(
          color: IdtColors.white,
          child: Column(
            children: [
              _header(),
              widget._isHotel ? _btnsHotel() : _btnsPlaces(),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,',
                          style: textTheme.textDescrip,
                          maxLines: viewModel.status.moreText ? null : 20,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: ClipRect(
                            // <-- clips to the 200x200 [Container] below
                            child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.2,
                            sigmaY: 0.2,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            color: IdtColors.white.withOpacity(
                                viewModel.status.moreText ? 0 : 0.5),
                          ),
                        )),
                      )
                    ],
                  ),
                  TextButton(
                    child: Text(
                        viewModel.status.moreText
                            ? 'MOSTRAR MENOS'
                            : 'SEGUIR LEYENDO',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.blueDetail.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: viewModel.readMore,
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              _footerImages(viewModel),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
