import 'dart:ui';

import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class AudioGuidePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => AudioGuideViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>(),

      ),
      builder: (context, _) {
        return AudioGuideWidget();
      },
    );
  }
}

class AudioGuideWidget extends StatefulWidget {
  @override
  _AudioGuideWidgetState createState() => _AudioGuideWidgetState();
}

class _AudioGuideWidgetState extends State<AudioGuideWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<AudioGuideViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: IdtAppBar(viewModel.onpenMenu),
        backgroundColor: IdtColors.white,
        extendBody: true,
        bottomNavigationBar: viewModel.status.openMenu ? null : IdtBottomAppBar(),
        floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _buildDiscover(viewModel)
      ),
    );
  }

  Widget _buildDiscover(AudioGuideViewModel viewModel) {


    final textTheme = Theme.of(context).textTheme;
    final menu = viewModel.status.openMenu ? IdtMenu(closeMenu: viewModel.closeMenu) : SizedBox.shrink();

    Widget imagesCard(String item, int index, List listItems) => (

      InkWell(
        onTap: viewModel.goDetailPage,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(IdtColors.black, BlendMode.difference),
                child: Image.network(
                  item,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 10,
              child: Container(
                  child: Icon(
                    Icons.favorite_border,
                    color: IdtColors.white,
                    size: 20,
                  )
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.headset_rounded,
                color: IdtColors.white,
                size: 60,
              )
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Text(
                  item.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textTheme.textWhiteShadow.copyWith(
                    fontSize: 11
                  )
                )
              ),
            ),
          ],
        ),
      )
    );

    Widget gridImagesCol3() => (

        GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 9,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: DataTest.imgList2.asMap().entries.map((entry) {
            final int index = entry.key;
            final String value = entry.value;

            return imagesCard(value, index, DataTest.imgList2);
          }).toList(),
        )
    );


    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(color: IdtColors.white),
                child: Center(
                  child: TitleSection('AUDIOGUÍAS')
                ),
              ),
              SizedBox(
                height: 25
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Divider(
                  color: IdtColors.black,
                  height: 2,
                  thickness: 1,
                ),
              ),
              SizedBox(
                  height: 40
              ),
              gridImagesCol3(),
              SizedBox(
                height: 55
              ),
            ],
          ),
        ),
        menu
      ],
    );
  }
}

