import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/places_model.dart';
import 'package:bogota_app/data/repository/repository.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/filters/filters_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/menu_filters.dart';
import 'package:bogota_app/widget/menu_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class FiltersPage extends StatelessWidget {

  final String title;

  FiltersPage(this.title);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => FiltersViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor

>()
      ),
      builder: (context, _) {
        return FiltersWidget(title);
      },
    );
  }
}

class FiltersWidget extends StatefulWidget {

  final String _title;

  FiltersWidget(this._title);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  @override
  void initState() {

    print("gastronomía");

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FiltersViewModel>().onInit();
    });
    //  final viewModel = context.read<EventsViewModel>();

  }



  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<FiltersViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: IdtAppBar(viewModel.onpenMenu),
        backgroundColor: IdtColors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: viewModel.status.openMenu ? null : IdtBottomAppBar(),
        floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _buildDiscover(viewModel)
      ),
    );
  }

  Widget _buildDiscover(FiltersViewModel viewModel) {

    List<String> listMenu = [
      "Opción 1",
      "Opción 2",
      "Opción 3",
      "Opción 4",
      "Opción 5",
    ];
    int count = 0;

    final textTheme = Theme.of(context).textTheme;

    final menu = viewModel.status.openMenu ? Padding(
      padding: EdgeInsets.only(top: 70),
      child: IdtMenu(closeMenu: viewModel.closeMenu),
    ) : SizedBox.shrink();

    final menuTap = viewModel.status.openMenuTab ?
        IdtMenuTap(
          listItems: listMenu,
          closeMenu: viewModel.closeMenuTab,
          isBlue: true,
          goFilters: viewModel.closeMenuTab,
        )
        : SizedBox.shrink();

    final menuTapFilter = viewModel.status.openMenuFilter ?
        IdtMenuFilter(
          listItems: listMenu,
          closeMenu: viewModel.closeMenuFilter,
          goFilters: viewModel.closeMenuFilter,
          filter1: viewModel.status.filter1,
          filter2: viewModel.status.filter2,
          filter3: viewModel.status.filter3,
          tapButton: viewModel.onTapButton,
        )
        : SizedBox.shrink();

    Widget _buttonsTapFilter(){
      return Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Todos',
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: IdtColors.blue,
                      size: 30,
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 8),
              color: IdtColors.blue.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.grayBtn, width: 0.5),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                )
              ),
              onPressed: viewModel.onpenMenuTab
            ),
          ),
          Expanded(
            child: OutlineButton(
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      'Filtrar',
                      textAlign: TextAlign.center,
                      style: textTheme.textDetail,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Icon(
                      Icons.add_road,
                      color: IdtColors.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),
              color: IdtColors.white,
              padding: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: IdtColors.grayBtn, width: 0.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                )
              ),
              onPressed: viewModel.onpenMenuFilter
            )
          )
        ],
      );
    }

    Widget imagesCard(String item, int index, List listItems, namePlace) => (

      InkWell(
        onTap: viewModel.goDetailPage,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius:
                // Validacion para el borde superior izquiero
                (index == 0)
                ? BorderRadius.only(topLeft: Radius.circular(15))

                // Validacion para el borde superior derecho
                : (index == 1)
                ? BorderRadius.only(topRight: Radius.circular(15))

                : BorderRadius.circular(0.0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 10,
              child: Container(
                child: Icon(
                  Icons.favorite_border,
                  color: IdtColors.white,
                  size: 19,
                )
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Text(
                  namePlace.toUpperCase(),
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

    Widget gridImagesCol3(List<DataPlacesModel> listItems) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: (
        //TODO: Pasar esta logica al ViewModel cuando se reciban los datos de la peticion
        StaggeredGridView.count(
          crossAxisCount: 6,
          shrinkWrap: true,
          physics: ScrollPhysics(),

          staggeredTiles:  listItems.asMap().entries.map((entry) {
            int rows = 3;
            count++;

            if(count > 2 && count < 6){
              rows = 2;
            }else if(count > 5 && count < 7){
              rows = 6;
            }else if(count > 6){
              rows = 3;
              count = 1;
            }
            return StaggeredTile.count(rows, 2);
          }).toList(),

          children:  listItems.asMap().entries.map((entry) {
            final int index = entry.key;
            final imageUrl =entry.value.image ?? '';
            final String value = IdtConstants.url_image + imageUrl;
            final String namePlace = entry.value.title ?? '';

            return imagesCard(value, index, listItems, namePlace);
          }).toList(),

          mainAxisSpacing: 8.0,
          crossAxisSpacing: 3.0,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        )
      ),
    );


    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: IdtColors.orange,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(bottom: 10),
                height: 100,
                alignment: Alignment.bottomCenter,
                child: Text(
                  widget._title.toUpperCase(),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleWhite,
                ),
              ),
              _buttonsTapFilter(),
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(color: IdtColors.white),
                child: RichText(
                  text: TextSpan(
                    text: 'DESCUBRE BOGOTÁ > ',
                    style: textTheme.titleBlack,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Plan con parejas',
                        style: textTheme.subTitleBlack
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25
              ),
              gridImagesCol3(viewModel.status.itemsFoodPlaces),
              SizedBox(
                height: 55
              ),
            ],
          ),
        ),
        menu,
        menuTap,
        menuTapFilter
      ],
    );
  }
}

