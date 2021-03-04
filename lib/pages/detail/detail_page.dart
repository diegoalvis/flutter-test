import 'dart:ui';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/bogota_icon.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/detail/detail_view_model.dart';
import 'package:bogota_app/utils/style_method.dart';
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
      create: (_) => DetailViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: IdtColors.white,
        body: _buildDiscover(viewModel)
      ),
    );
  }

  Widget _buildDiscover(DetailViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    Widget _header (){
      return Stack(
        children: [
          Column(
            children: [
              Image(
                image: AssetImage(IdtAssets.splash),
                width: size.width,
                height: size.height * 0.5,
                fit: BoxFit.fill,
              ),
              /*SizedBox(
                height: size.height * 0.1
              )*/
            ],
          ),
          /*Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              height: size.height * 0.8,
              child: SvgPicture.asset(
                IdtAssets.curve_ltr,
                color: IdtColors.white,
                fit: BoxFit.fill
              ),
            )
          ),*/
          Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Icon(
                  Bogota_icon.curve1,
                  color: Colors.white,
                  size: 132,
                ),
                height: 130,
              )
            )
          ),
          Positioned(
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
                    children: [
                      RatingBar.builder(
                        initialRating: 4.3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star_outlined,
                          color: IdtColors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '4.3/5',
                        style: textTheme.textWhiteShadow,
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
                    style: textTheme.textWhiteShadow.copyWith(
                      fontSize: 21
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              color: Colors.transparent,
              height: 90,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    width: size.width * 1 / 2,
                    color: IdtColors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10.0),
                      child: IconButton(
                        autofocus: false,
                        color: IdtColors.red,
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          Bogota_icon.back,
                          color: IdtColors.white,
                          size: 40.0,
                        ),
                        onPressed: () {
                          print("Favorite");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 1 / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          color: IdtColors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: IconButton(
                              autofocus: false,
                              color: IdtColors.transparent,
                              alignment: Alignment.centerRight,
                              icon: Icon(
                                Icons.share,
                                color: IdtColors.white,
                                size: 30.0,
                              ),
                              onPressed: () {
                                print("Share");
                              },
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: 50,
                          color: IdtColors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: IconButton(
                              autofocus: false,
                              color: IdtColors.red,
                              alignment: Alignment.centerRight,
                              icon: Icon(
                                Bogota_icon.heart1,
                                color: IdtColors.red,
                                size: 30.0,
                              ),
                              onPressed: () {
                                print("appbar");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget _footerImages(DetailViewModel viewModel){
      return Stack(
        children: [

          Stack(
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: 0, top: 0),
                  width: size.width,
                  height: size.height * 0.5,
                  color: IdtColors.white,
                  child: ListView.builder(
                    itemCount: DataTest.imgList2.length,
                    shrinkWrap: true,
                    itemExtent: MediaQuery.of(context).size.width,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: IdtColors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topRight: Radius.circular(0.00), // FLUTTER BUG FIX
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: IdtColors.grayBtn,
                                    offset: Offset(0, 0),
                                    blurRadius: 11.0,
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.5,
                                    color: Colors.white,
                                    child: Image.network(
                                      DataTest.imgList2[index],
                                      width: size.width,
                                      height: size.height * 0.5,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ),
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              ),
              Positioned(
                width: size.width * 0.98,
                right: size.width * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(top: 180.0, left: 20),
                  child: IconButton(
                    iconSize: 35,
                    alignment: Alignment.centerLeft,
                    icon: FittedBox(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: IdtColors.grayBtn,
                        ),
                        onPressed: () {
                        },
                      ),
                    )
                  ),
                ),
              ),
              Positioned(
                width: size.width * 0.98,
                left: size.width * 0.74,
                child: Padding(
                  padding: EdgeInsets.only(top: 175.0, left: 45),
                  child: IconButton(
                    iconSize: 35,
                    alignment: Alignment.centerLeft,
                    icon: FittedBox(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: IdtColors.white,
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: IdtColors.grayBtn,
                        ),
                        onPressed: () {
                        },
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: Icon(
                  Bogota_icon.curve2,
                  color: Colors.white,
                  size: 132,
                ),
                width: 410,
                height: 130,
              )
            )
          ),
        ],
      );
    }

    Widget _btnsPlaces(){

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.orange, width: 1),
                borderRadius: BorderRadius.circular(80.0)
            ),
            padding: EdgeInsets.all(0.0),
            child: Container(
                constraints: BoxConstraints(
                    maxWidth: 100.0,
                    maxHeight: 55
                ),
                decoration: StylesMethodsApp().decorarStyle(
                    IdtGradients.orange,
                    30,
                    Alignment.bottomCenter,
                    Alignment.topCenter
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on,
                  color: IdtColors.white,
                  size: 50,
                )
            ),
            onPressed: () {

            },
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.blue, width: 1),
                borderRadius: BorderRadius.circular(80.0)
            ),
            padding: EdgeInsets.all(0.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: 100.0,
                  maxHeight: 55
              ),
              decoration: StylesMethodsApp().decorarStyle(
                  IdtGradients.blueDark,
                  30,
                  Alignment.bottomCenter,
                  Alignment.topCenter
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.headset_rounded,
                color: IdtColors.white,
                size: 50,
              )
            ),
            onPressed: viewModel.goPlayAudioPage,
          )
        ],
      );
    };

    Widget _btnGradient(IconData icon, Color color, List<Color> listColors){

      return RaisedButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: color, width: 1),
            borderRadius: BorderRadius.circular(17.0)
        ),
        padding: EdgeInsets.all(0),
        child: Container(
            width: size.width * 0.7,
            decoration: StylesMethodsApp().decorarStyle(
                listColors,
                17,
                Alignment.bottomCenter,
                Alignment.topCenter
            ),
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
            )
        ),
        onPressed: () {

        },
      );
    }

    Widget _btnsHotel(){

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _btnGradient(Icons.location_on, IdtColors.orange, IdtGradients.orange),
          SizedBox(
            height: 5,
          ),
          _btnGradient(Icons.phone, IdtColors.green, IdtGradients.green),
          SizedBox(
            height: 5,
          ),
          _btnGradient(Icons.wifi_tethering_sharp, IdtColors.blueDark, IdtGradients.blueDark),
          SizedBox(
            height: 10,
          ),
        ],
      );
    };

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
                /*Padding(
                  padding: EdgeInsets.all(50.0),
                  child: ReadMoreText(
                    'Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de. Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero, que exhibe arte de Fernando Botero, y el Museo del Oro, con piezas de, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,, Bogotá es la extensa capital en altura de Colombia. La Candelaria, su populares, incluido el Museo Botero,',
                    textAlign: TextAlign.justify,
                    trimLines: 20,
                    colorClickableText: Colors.blue,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'SEGUIR LEYENDO',
                    trimExpandedText: ' LEER MENOS',
                    style: textTheme.textDescrip,
                  ),
                ),*/
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
                      child: ClipRect(  // <-- clips to the 200x200 [Container] below
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 0.2,
                            sigmaY: 0.2,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            color: IdtColors.white.withOpacity( viewModel.status.moreText ? 0 : 0.5),
                          ),
                        )
                      ),
                    )
                  ],
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    viewModel.status.moreText ? 'MOSTRAR MENOS' : 'SEGUIR LEYENDO',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.blueDetail.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  onPressed: viewModel.readMore,
                )
              ],
            ),
            _footerImages(viewModel),
            SizedBox(
              height: 5,
            )
          ],
        )
      ),
    );
  }
}
