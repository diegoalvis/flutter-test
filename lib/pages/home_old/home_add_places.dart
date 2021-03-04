import 'package:bogota_app/data/testData.dart';
import 'package:bogota_app/pages/components/appbar.dart';
import 'package:bogota_app/pages/components/gradientIcon.dart';
import 'package:bogota_app/pages/components/title_lugares.dart';
import 'package:bogota_app/pages/components/title_sec.dart';
import 'package:bogota_app/pages/components/verticalgrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bogota_app/utils/style_method.dart';

class Home_Add_Places extends StatefulWidget {
  @override
  _Home_Add_PlacesState createState() => _Home_Add_PlacesState();
}

String assetName = 'lib/assets/logo.svg';

class _Home_Add_PlacesState extends State<Home_Add_Places> {
  final a = AppBar_Component();
  final testdata = testData();

  Widget svg = SvgPicture.asset(
    assetName,
    fit: BoxFit.cover,
    alignment: Alignment.center,
    height: 50.0,
    width: 100.0,
    allowDrawingOutsideViewBox: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar_Component(),
        body: Container(
          child: Center(child: HorizontalAndVerticalListView()),
        ));
  }
}

class HorizontalAndVerticalListView extends StatefulWidget {
  @override
  _HorizontalAndVerticalListViewState createState() =>
      _HorizontalAndVerticalListViewState();
}

class _HorizontalAndVerticalListViewState
    extends State<HorizontalAndVerticalListView> {
  @override
  final g = GridVertical_Component();
  final ic = GradientIcon();
  final stylemethod = StylesMethodsApp();

  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        Title_Lugares(),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            height: 220,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Color(0xFFF0F0F0)),
            child: Icon(Icons.add, color: Color(0XFF666666), size: 80),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 35,
            child: Container(color: Colors.white),
          ),
        ),
        Title_Sec("IMPERDIBLE EN BOGOTÁ"),
        g.GridVertical(context, testData().imgList2, testData().textList2)
      ],
    );
  }
}
