import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/discover/discover_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/menu_tap.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          DiscoverViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return DiscoverWidget();
      },
    );
  }
}

class DiscoverWidget extends StatefulWidget {

  @override
  _DiscoverWidgetState createState() => _DiscoverWidgetState();
}


class _DiscoverWidgetState extends State<DiscoverWidget> {

  @override
  void initState() {
    final viewModel = context.read<DiscoverViewModel>();
    viewModel.getDiscoveryData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiscoverViewModel>();

    return SafeArea(
      child: Scaffold(
          appBar: IdtAppBar(viewModel.onpenMenu),
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

  Widget _buildDiscover(DiscoverViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;

    final List<DataModel> _places = viewModel.places;
    final List<DataModel> _categories = viewModel.categories;
    final List<DataModel> _subcategories = viewModel.subcategories;
    final List<DataModel> _zones = viewModel.zones;

    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    final menu = viewModel.status.openMenu
        ? IdtMenu(closeMenu: viewModel.closeMenu)
        : SizedBox.shrink();

    final menuTap = viewModel.status.openMenuTab
        ? IdtMenuTap(
            listItems: viewModel.status.listOptions,
            closeMenu: viewModel.closeMenuTab,
            goFilters: (item) => viewModel.goFiltersPage(
                item, _categories, _subcategories, _zones))
        : SizedBox.shrink();

    Widget _buttonTap(String label, VoidCallback onTap) {
      return Expanded(
        child: TextButton(
          child: Text(label,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.subTitleBlack),
          onPressed: onTap,
        ),
      );
    }

    Widget imagesCard(DataModel item, int index, List listItems) => (InkWell(
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
                        : (index == 2)
                            ? BorderRadius.only(topRight: Radius.circular(15))

                            // Validaciones para el borde inferior izquiero
                            : (index == (listItems.length - 3) &&
                                    index % 3 == 0)
                                ? BorderRadius.only(
                                    bottomLeft: Radius.circular(15))
                                : (index == (listItems.length - 2) &&
                                        index % 3 == 0)
                                    ? BorderRadius.only(
                                        bottomLeft: Radius.circular(15))
                                    : (index == (listItems.length - 1) &&
                                            index % 3 == 0)
                                        ? BorderRadius.only(
                                            bottomLeft: Radius.circular(15))

                                        // Validacion para el borde inferior derecho
                                        : (index == (listItems.length - 1) &&
                                                (index + 1) % 3 == 0)
                                            ? BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(15))
                                            : BorderRadius.circular(0.0),
                child: SizedBox(
                  child: Image.network(
                    IdtConstants.url_image + item.image!,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
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
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: _places.asMap().entries.map((entry) {
            final int index = entry.key;
            final DataModel value = entry.value;

            return imagesCard(value, index, _places);
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
                child: Center(child: TitleSection('DESCUBRE BOGOTÁ')),
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Divider(
                  color: IdtColors.black,
                  height: 2,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buttonTap('Plan',
                        () => viewModel.onpenMenuTab(_categories, 'category')),
                    _buttonTap(
                        'Producto',
                        () => viewModel.onpenMenuTab(
                            _subcategories, 'subcategory')),
                    _buttonTap(
                        'Zona', () => viewModel.onpenMenuTab(_zones, 'zone')),
                    _buttonTap('Audioguías', viewModel.goAudioGuidePage),
                  ],
                ),
              ),
              SizedBox(height: 15),
              gridImagesCol3(),
              SizedBox(height: 55),
            ],
          ),
        ),
        menu,
        menuTap,
        loading
      ],
    );
  }
}
