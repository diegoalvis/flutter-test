import 'dart:ui';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/result_search/result_search_view_model.dart';
import 'package:bogota_app/pages/search/search_view_model.dart';
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
  final List<DataModel> results;

  ResultSearchPage(this.results);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResultSearchViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return ResultSearchWidget(results);
      },
    );
  }
}

class ResultSearchWidget extends StatefulWidget {
  final List<DataModel> _results;

  ResultSearchWidget(this._results);


  @override
  _ResultSearchWidgetState createState() => _ResultSearchWidgetState();
}

class _ResultSearchWidgetState extends State<ResultSearchWidget> {
  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<SearchViewModel>().onInit(widget._results);
      print(widget._results);
    });

    // // una vez tengas la info la pasas aca
    // viewModel.onTapButton(index, id, items);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ResultSearchViewModel>();

    return SafeArea(
      child: Scaffold(
          appBar: IdtAppBar(viewModel.openMenu),
          backgroundColor: IdtColors.white,
          extendBody: true,
          floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
          bottomNavigationBar: viewModel.status.openMenu
              ? null
              : IdtBottomAppBar(discoverSelect: false, searchSelect: true),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: _buildDiscover(viewModel)),
    );
  }

  Widget _buildDiscover(ResultSearchViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child:
          viewModel.status.openMenu ? IdtMenu(closeMenu: viewModel.closeMenu) : SizedBox.shrink(),
    );

    Widget gridImagesCol() => (ListView.builder(
          itemCount: DataTest.imgList.length,
          physics: ScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 50),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: viewModel.goDetailPage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      DataTest.imgList[index],
                      height: 170.0,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(DataTest.textList[index], style: textTheme.titleBlack.copyWith(fontSize: 13)),
                SizedBox(height: 30),
              ],
            );
          },
        ));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35),
              RichText(
                text: TextSpan(
                  text: 'Resultados para: ',
                  style: textTheme.titleBlack.copyWith(fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Naturaleza',
                        style: textTheme.subTitleBlack.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 17,
                          textBaseline: TextBaseline.alphabetic,
                          decorationThickness: 1.5,
                          decorationColor: IdtColors.black,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 30),
              gridImagesCol(),
              SizedBox(height: 60),
            ],
          ),
        ),
        menu
      ],
    );
  }
}
