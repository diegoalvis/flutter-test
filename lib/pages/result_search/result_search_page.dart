import 'dart:ui';

import 'package:bogota_app/api/repository/interactor/api_interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/result_search/result_search_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ResultSearchPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ResultSearchViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return ResultSearchWidget();
      },
    );
  }
}

class ResultSearchWidget extends StatefulWidget {
  @override
  _ResultSearchWidgetState createState() => _ResultSearchWidgetState();
}

class _ResultSearchWidgetState extends State<ResultSearchWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<ResultSearchViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: IdtAppBar(viewModel.onpenMenu),
        backgroundColor: IdtColors.white,
        bottomNavigationBar: IdtBottomAppBar(discoverSelect: false, searchSelect: true),
        extendBody: true,
        floatingActionButton: IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _buildDiscover(viewModel)
      ),
    );
  }

  Widget _buildDiscover(ResultSearchViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final menu = viewModel.status.openMenu ? IdtMenu(closeMenu: viewModel.closeMenu) : SizedBox.shrink();

    Widget imagesCard(String item, int index, List listItems) => (

        Center(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item,
                  height: 180,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                item,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.titleBlack.copyWith(
                  fontSize: 14
                ),
              )
            ],
          ),
        )
    );

    Widget gridImagesCol() => (

        ListView.builder(
          itemCount: 6,
          physics: ScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 40),
          shrinkWrap: true,
          itemBuilder: (context, index){
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/3/35/BOG_Iglesia_de_la_Tercera.JPG',
                    height: 170.0,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Nombre del lugar',
                  style: textTheme.titleBlack.copyWith(
                    fontSize: 13
                  )
                ),
                SizedBox(height: 30),
              ],
            );
          },
        )
    );


    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30
              ),
              RichText(
                text: TextSpan(
                  text: 'Resultados para: ',
                  style: textTheme.titleBlack.copyWith(
                    fontSize: 18
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Naturaleza',
                      style: textTheme.subTitleBlack.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        textBaseline: TextBaseline.alphabetic,
                        decorationThickness: 1.5,
                        decorationColor: Colors.black,
                      )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30
              ),
              gridImagesCol(),
              SizedBox(
                height: 60
              ),
            ],
          ),
        ),
        menu
      ],
    );
  }
}

