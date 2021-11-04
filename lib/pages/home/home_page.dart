import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/data/model/words_and_menu_images_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_view_model.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:bogota_app/widget/NFMarquee.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/home/other_places.dart';
import 'package:bogota_app/widget/home/saved_places.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final namePage = 'home_page';
  final List<String> imgsMenu;
  final List<String> textsMenu;
  final WordsAndMenuImagesModel menuAndWords;

  HomePage(
  this.imgsMenu,
    this.textsMenu,
    this.menuAndWords,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          HomeViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return HomeWidget(
          imgsMenu,
          textsMenu,
          menuAndWords
        );
      },
    );
  }
}

class HomeWidget extends StatefulWidget {
  final List<String> _imgsMenu;
  final List<String> _textsMenu;
  final WordsAndMenuImagesModel _menuAndWords;
  HomeWidget(this._imgsMenu, this._textsMenu, this._menuAndWords);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();

}

class _HomeWidgetState extends State<HomeWidget> {
  final _route = locator<IdtRoute>();
  final scrollController = ScrollController();
  StreamSubscription<HomeEffect>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      WordsAndMenuImagesModel dictionary = BoxDataSesion.getDictionary();
      context.read<HomeViewModel>().onInit(
        widget._imgsMenu,
        widget._textsMenu,
        widget._menuAndWords

      );
    });

    final viewModel = context.read<HomeViewModel>();
    
    _effectSubscription = viewModel.effects.listen((event) {
      if (event is HomeValueControllerScrollEffect) {
        print(event.next);
        scrollController.animateTo(
            event.next
                ? scrollController.offset + IdtConstants.itemSize
                : scrollController.offset - IdtConstants.itemSize,
            curve: Curves.linear,
            duration: Duration(milliseconds: event.duration));
      } else if (event is ShowDialogSuggestionLoginEffect) {
        context.showDialogObservation(
          titleDialog: ' Funcionalidad para usuarios registrados',
          bodyTextDialog:
              '* Aqui tendras la lista de todos tus lugares favoritos o de interes que hayas agregado \u2665 *\n\n¿Quieres iniciar sesion?',
          textPrimaryButton: 'Ir al login...',
          textSecondButtom: 'Luego',
          actionPrimaryButtom: _route.goLogin,
        );
      } else if (event is ShowDialogSavedPlacedEffect) {
        context.showDialogObservation(
            titleDialog: "Lugares Guardados",
            bodyTextDialog:
                "* Aqui podras ver todos tus lugares guardados como favoritos *\n\n  Agregalos con un \u2665");
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<HomeViewModel>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            appBar: IdtAppBar(
              viewModel.openMenu,
              backButton: false,
            ),
            backgroundColor: IdtColors.white,
            extendBody: true,
            bottomNavigationBar: viewModel.status.openMenu
                ? null
                : IdtBottomAppBar(discoverSelect: false),
            floatingActionButton:
                viewModel.status.openMenu ? null : IdtFab(homeSelect: true),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: _buildHome(viewModel)),
      ),
    );
  }

  Widget _buildHome(HomeViewModel viewModel) {
    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    final size = MediaQuery.of(context).size;

    void optionSelectedHome(
      int index,
    ) {
      switch (index) {
        case 0:
          _route.goDiscoverUntil();
          break;
        case 1:
          _route.goEvents(index);
          break;
        case 2:
          _route.goEat(index);
          break;
        case 3:
          _route.goSleeps(index);
          break;
        case 4:
          _route.goAudioGuideUntil(index);
          break;
        case 5:
          _route.goUnmissableUntil(index);
          break;

        default:
          //statements;
          break;
      }
    }

    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(
              closeMenu: viewModel.closeMenu,
            )
          : SizedBox.shrink(),
    );

    return Stack(
      children: [
        SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget._textsMenu.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => optionSelectedHome(index),
                      child: Container(
                        height: (size.height - 28 * widget._textsMenu.length) /
                            widget._textsMenu.length,
                        decoration: BoxDecoration(
                          color: widget._imgsMenu.length != 0
                              ? DataTest.colorsHomeList[index].withOpacity(0.7)
                              : null,
                          image: DecorationImage(
                            image: widget._imgsMenu.length != 0
                                ? index != 5
                                    ? NetworkImage(IdtConstants.url_image +
                                        widget._imgsMenu[index]
                                            .replaceAll(' ', ''))
                                    : AssetImage(IdtAssets.splash)
                                        as ImageProvider
                                : AssetImage(IdtAssets.splash) as ImageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      widget._textsMenu[index].toUpperCase(),
                                      maxFontSize: 30,
                                      minFontSize: 22,
                                      style: TextStyle(
                                        color: IdtColors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                              offset: Offset(3, 2),
                                              blurRadius: 3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: IdtColors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
              ),
              // TextButton(
              //   child: Text('Enviar ubicacion'),
              //   onPressed: viewModel.setLocationUser,
              // ),
              // BoxDataSesion.isLoggedIn
              SavedPlaces(
                viewModel.status.openSaved,
                viewModel.onpenSavedPlaces,
                viewModel.status.notSaved,
                viewModel.addSavedPLaces,
                viewModel.suggestionLogin,
                viewModel.status.seeAll,
                viewModel.onTapSeeAll,
                viewModel.onChangeScrollController,
                scrollController,
                viewModel.goDetailPage,
                viewModel.status.itemsSavedPlaces,
                viewModel.status.itemAudiosSavedPlaces,
                viewModel.status.listBoolAudio,
                viewModel.status.listBoolAll,
              ),
              // : SizedBox.shrink(),
              OtherPlaces(
                onTapCard: viewModel.goDetailPage,
                goDiscover: viewModel.goDiscoverPage,
                resUnmissable: viewModel.status.itemsUnmissablePlaces,
                resFood: viewModel.status.itemsEatPlaces,
                bestRated: viewModel.status.itemsbestRatedPlaces,
              )
            ],
          ),
        ),
        loading,
        menu,
      ],
    );
  }

  // List<String> widget._textsMenu = [
  //   'Descubre Bogotá',
  //   'Eventos',
  //   '¿Dónde comer?',
  //   '¿Dónde Dormir?',
  //   'Audioguias',
  //   'Imperdibles'
  // ];
}
