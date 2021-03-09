import 'dart:ui';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/bogota_icon.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/event_detail/event_detail_view_model.dart';
import 'package:bogota_app/utils/style_method.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class EventDetailPage extends StatelessWidget {

  final bool isHotel;

  EventDetailPage({this.isHotel = false});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => EventDetailViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return EventDetailWidget(isHotel);
      },
    );
  }
}

class EventDetailWidget extends StatefulWidget {

  final bool _isHotel;

  EventDetailWidget(this._isHotel);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<EventDetailViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: IdtBottomAppBar(),
          extendBody: true,
          extendBodyBehindAppBar: true,
          floatingActionButton: IdtFab(),
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
                  Icons.location_on,
                  color: IdtColors.white,
                  size: 50,
                ),
                onPressed: () {

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

    Widget _footerImages(EventDetailViewModel viewModel){
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
                    ),
                    onPressed: () {  },
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
                    ),
                    onPressed: () {  },
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
                height: 20,
              ),
              _btnsPlaces(),
              SizedBox(
                height: 20,
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
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 0),
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
              fit: BoxFit.cover,
            )
        ),
        height: size.height,
        width: size.width,
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
                      color: IdtColors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: IconButton(
                          autofocus: false,
                          color: IdtColors.red,
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Bogota_icon.back,
                            color: IdtColors.white,
                            size: 50.0,
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
                            Icons.favorite,
                            color: IdtColors.red,
                            size: 40.0,
                          ),
                          onPressed: () {
                            print("Favorite");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 65,
                  ),
                  _body(),
                  SizedBox(
                    height: 85,
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}

