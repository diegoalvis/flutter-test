import 'dart:ui';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/discover/discover_view_model.dart';
import 'package:bogota_app/pages/unmissable/unmissable_view_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:bogota_app/widget/title_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../app_theme.dart';

class UnmissablePage extends StatelessWidget {
  final int? optionIndex;
  static final String namePage = 'imperdible_page';

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
      context.read<UnmissableViewModel>().getUnmissableResponse(option: 0);
    });
  }

//** Este metodo no es necesario, ya que se maneja atraves del viewModel, dependienndo del Boton
  // void reload(state){
  //     if(state){
  //     WidgetsBinding.instance!.addPostFrameCallback((_) {
  //       context.read<UnmissableViewModel>().getBestRatedResponse();});
  //     super.initState();
  //  }else{
  //     initState();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UnmissableViewModel>();
    // VisibilityDetector Esta funcionalidad permitiria conocer si la pantalla se tapo con algo
    // por ejemplo con otra pantalla, al regresar actualice la pantalla por si dio corazón en el detalle 
    return VisibilityDetector(
      key: Key('unnmisable-page-visible'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage == 100) {
          context.read<UnmissableViewModel>().onInit();
        }
      },
      child: SafeArea(
      child: WillPopScope(
          onWillPop: viewModel.offMenuBack,
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
      ),),
    );
  }

  Widget _buildDiscover(UnmissableViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    late List<DataModel> _unmissable = viewModel.status.itemsUnmissablePlaces;
    final menu = AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: viewModel.status.openMenu
            ? IdtMenu(
                closeMenu: viewModel.closeMenu,
                optionIndex: TitlesMenu.impedibles,
              )
            : SizedBox.shrink());
    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    Widget _buttonTap(
      String label,
      bool isSelected,
      VoidCallback onTap,
    ) {
      return Expanded(
        child: TextButton(
          child: Column(
            children: [
              Text(label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.subTitleBlack),
              isSelected
                  ? Container(
                      height: 5,
                      width: 50,
                      color: Colors.black,
                    )
                  : SizedBox.shrink()
            ],
          ),
          onPressed: onTap,
        ),
      );
    }

    Widget imagesCard(DataModel item, int index) => (
      
      GestureDetector(
          onDoubleTap: BoxDataSesion.isLoggedIn
              ? () {
                  viewModel.onTapFavorite(item.id.toString());
                }
              : null,
          onTap: () => viewModel.goDetailPage(item.id.toString()),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  IdtConstants.url_image + item.image!,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 10,
                child: BoxDataSesion.isLoggedIn == true
                    ? IconButton(
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          item.isFavorite == true
                              ? IdtIcons.heart2
                              : Icons.favorite_border,
                          color: item.isFavorite == true
                              ? IdtColors.red
                              : IdtColors.white,
                        ),
                        iconSize: 20,
                        onPressed: () => viewModel.onTapFavorite(item.id),
                      )
                    : Container(),
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

    Widget gridImagesCol3(List<DataModel> dataTap) => (GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 7,
          mainAxisSpacing: 9,
          //childAspectRatio: 7/6,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: dataTap.asMap().entries.map((entry) {
            final int index = entry.key;
            final DataModel value = entry.value;

            return imagesCard(value, index);
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
                child: Container(
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buttonTap(
                        'Recomendados',
                        viewModel.status.currentOption == 0,
                        () => viewModel.getUnmissableResponse(option: 0),
                      ),
                      _buttonTap(
                        'Mejor calificados',
                        viewModel.status.currentOption == 1,
                        () => viewModel.getBestRatedResponse(option: 1),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              gridImagesCol3(_unmissable),
              SizedBox(height: 55),
            ],
          ),
        ),
        menu,
        loading
      ],
    );
  }
}
