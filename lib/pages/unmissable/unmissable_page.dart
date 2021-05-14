import 'dart:ui';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/unmissable/unmissable_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class UnmissablePage extends StatelessWidget {
  final int? optionIndex;

  UnmissablePage({this.optionIndex});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          UnmissableViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return UnmissableWidget(optionIndex);
      },
    );
  }
}

class UnmissableWidget extends StatefulWidget {
  final int? optionIndex;

  const UnmissableWidget(this.optionIndex);

  @override
  _UnmissableWidgetState createState() => _UnmissableWidgetState();
}

class _UnmissableWidgetState extends State<UnmissableWidget> {
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<UnmissableViewModel>().getUnmissableResponse();});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UnmissableViewModel>();

    return SafeArea(
      child: Scaffold(
          appBar: IdtAppBar(viewModel.openMenu),
          backgroundColor: IdtColors.white,
          extendBody: true,
          bottomNavigationBar:
              viewModel.status.openMenu ? null : IdtBottomAppBar(),
          floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: _buildDiscover(viewModel)),
    );
  }

  Widget _buildDiscover(UnmissableViewModel viewModel) {

    final textTheme = Theme.of(context).textTheme;
    final List<DataModel> _unmissable = viewModel.status.itemsUnmissablePlaces;
    final menu = AnimatedSwitcher(duration: Duration(milliseconds: 500), child: viewModel.status.openMenu
        ? IdtMenu(closeMenu: viewModel.closeMenu, optionIndex: widget.optionIndex,)
        : SizedBox.shrink());

    Widget _buttonTap(String label) {
      return Expanded(
        child: TextButton(
          child: Text(label,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.subTitleBlack),
          onPressed: () {},
        ),
      );
    }

    ;

    Widget imagesCard(DataModel item, int index, List listItems) => (InkWell(
          onTap: () =>viewModel.goDetailPage(index.toString()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  IdtConstants.url_image + item.image!,
                  height: 250,
                  fit: BoxFit.fill,
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
                )),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                    child: Text(item.title!.toUpperCase(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:
                            textTheme.textWhiteShadow.copyWith(fontSize: 11))),
              ),
            ],
          ),
        ));

    Widget gridImagesCol3() => (GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 9,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: _unmissable.asMap().entries.map((entry) {
            final int index = entry.key;
            final DataModel value = entry.value;

            return imagesCard(value, index, DataTest.imgList2);
          }).toList(),
        ));

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(color: IdtColors.white),
                child: Center(child: TitleSection('IMPERDIBLES')),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Divider(
                  color: IdtColors.black,
                  height: 2,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 24, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buttonTap('Recomendados'),
                    _buttonTap('Mejor calificados')
                  ],
                ),
              ),
              SizedBox(height: 25),
              gridImagesCol3(),
              SizedBox(height: 55),
            ],
          ),
        ),
        menu
      ],
    );
  }
}
