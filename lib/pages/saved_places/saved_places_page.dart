import 'dart:ui';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/saved_places/saved_places_view_model.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class SavedPlacesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => SavedPlacesViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return SavedPlacesWidget();
      },
    );
  }
}

class SavedPlacesWidget extends StatefulWidget {
  @override
  _SavedPlacesWidgetState createState() => _SavedPlacesWidgetState();
}

class _SavedPlacesWidgetState extends State<SavedPlacesWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<SavedPlacesViewModel>();

    return Scaffold(
      backgroundColor: IdtColors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: IdtFab(),
      bottomNavigationBar: IdtBottomAppBar(discoverSelect: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _buildSavedPlaces(viewModel)
    );
  }

  Widget _buildSavedPlaces(SavedPlacesViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;

    Widget gridImagesCol() {

      return ListView.builder(
        itemCount: DataTest.imgList2.length,
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 0),
        shrinkWrap: true,
        itemBuilder: (context, index) {

          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: viewModel.goDetailPage,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Image.network(
                              DataTest.imgList2[index],
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              DataTest.textList2[index],
                              style: textTheme.textButtomWhite.copyWith(
                                  fontSize: 16
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                  FlutterSwitch(
                    value: viewModel.status.listSwitch[index],
                    switchBorder: Border.all(color: IdtColors.grayBtn),
                    activeColor: IdtColors.white,
                    activeToggleColor: IdtColors.greenDark,
                    inactiveColor: IdtColors.white,
                    height: 30,
                    width: 60,
                    padding: 1,
                    inactiveToggleColor: IdtColors.grayBtn.withOpacity(0.9),
                    onToggle: (value) => viewModel.changeSwitch(value, index)
                  )
                ],
              ),
              SizedBox(height: 5),
            ],
          );
        }
      );
    }

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: IdtGradients.blueDark,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
            padding: EdgeInsets.only(left: 20, right: 20, top: 110, bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LUGARES GUARDADOS',
                  style: textTheme.titleWhite.copyWith(
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Modo Offline',
                    textAlign: TextAlign.right,
                    style: textTheme.textButtomWhite.copyWith(
                      fontSize: 12
                    ),
                  ),
                ),
                gridImagesCol()
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 0,
          left: 0,
          child: Container(
            alignment: Alignment.centerLeft,
            color: IdtColors.transparent,
            padding: EdgeInsets.only(left: 14),
            child: IconButton(
              color: IdtColors.red,
              alignment: Alignment.centerRight,
              icon: SvgPicture.asset(
                IdtAssets.back_white,
                color: IdtColors.white,
              ),
              iconSize: 50,
              onPressed: () {
                print("Back Button");
              },
            ),
          ),
        ),
      ],
    );
  }
}

