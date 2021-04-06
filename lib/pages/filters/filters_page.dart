import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/filters/filters_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/menu_filters.dart';
import 'package:bogota_app/widget/menu_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class FiltersPage extends StatelessWidget {

  final String section;
  final DataModel item;
  final List<DataModel> places;
  final List<DataModel> categories;
  final List<DataModel> subcategories;
  final List<DataModel> zones;

  FiltersPage(this.section, this.item, this.places, this.categories,
      this.subcategories, this.zones);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => FiltersViewModel(
        locator<IdtRoute>(),
        locator<ApiInteractor>()
      ),
      builder: (context, _) {
        return FiltersWidget(section, item, places, categories, subcategories, zones);
      },
    );
  }
}

class FiltersWidget extends StatefulWidget {

  final String _section;
  final DataModel _item;
  final List<DataModel> _places;
  final List<DataModel> _categories;
  final List<DataModel> _subcategories;
  final List<DataModel> _zones;

  FiltersWidget(this._section, this._item, this._places, this._categories,
      this._subcategories, this._zones);

  @override
  _FiltersWidgetState createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FiltersViewModel>().onInit(
        widget._section, widget._categories, widget._subcategories, widget._zones, widget._places, widget._item
      );
    });
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

    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    int count = 0;
    final textTheme = Theme.of(context).textTheme;

    final menu = viewModel.status.openMenu ? Padding(
      padding: EdgeInsets.only(top: 70),
      child: IdtMenu(closeMenu: viewModel.closeMenu),
    ) : SizedBox.shrink();

    final menuTap = viewModel.status.openMenuTab ?
        IdtMenuTap(
          listItems: viewModel.status.itemsFilter,
          closeMenu: viewModel.closeMenuTab,
          isBlue: true,
          goFilters: (item) => viewModel.getDataFilterAll(item, widget._section),
        )
        : SizedBox.shrink();

    final menuTapFilter = viewModel.status.openMenuFilter ?
        IdtMenuFilter(
          listCategories: widget._categories,
          listSubcategories: widget._subcategories,
          listZones: widget._zones,
          closeMenu: viewModel.closeMenuFilter,
          goFilters: viewModel.getDataFilter,
          filter1: viewModel.status.filterSubcategory,
          filter2: viewModel.status.filterZone,
          filter3: viewModel.status.filterCategory,
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

    Widget gridImagesCol3(List<DataModel> listItems) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: (
        StaggeredGridView.count(
          crossAxisCount: 6,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          staggeredTiles: viewModel.status.staggedList,
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
                  'CULTURA'.toUpperCase(),
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
                        text: viewModel.status.section,
                        style: textTheme.subTitleBlack
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25
              ),
              gridImagesCol3(viewModel.status.placesFilter),
              SizedBox(
                height: 55
              ),
            ],
          ),
        ),
        menu,
        menuTap,
        menuTapFilter,
        loading,
      ],
    );
  }
}

