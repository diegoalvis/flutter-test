import 'dart:async';

import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/mock/data/DataTest.dart';
import 'package:bogota_app/pages/home/home_effect.dart';
import 'package:bogota_app/pages/home/home_view_model.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/home/other_places.dart';
import 'package:bogota_app/widget/home/saved_places.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return HomeWidget();
      },
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final scrollController = ScrollController();
  StreamSubscription<HomeEffect>? _effectSubscription;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<HomeViewModel>().onInit();
    });

    final viewModel = context.read<HomeViewModel>();

    // _effectSubscription = viewModel.effects.listen((event) {
    //   if (event is HomeValueControllerScrollEffect) {
    //     scrollController.animateTo(
    //         event.next
    //             ? scrollController.offset + IdtConstants.itemSize
    //             : scrollController.offset - IdtConstants.itemSize,
    //         curve: Curves.linear,
    //         duration: Duration(milliseconds: event.duration));
    //   } else if (event is ShowDialogEffect) {
    //     context.showDialogObservation(titleDialog: 'Titulo del Dialogo',bodyTextDialog: 'Cuerpo del Dialogo');
    //   }
    // });
    super.initState();
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
      child: Scaffold(
          appBar: IdtAppBar(
            viewModel.openMenu,
            backButton: false,
          ),
          backgroundColor: IdtColors.white,
          extendBody: true,
          bottomNavigationBar:
              viewModel.status.openMenu ? null : IdtBottomAppBar(discoverSelect: false),
          floatingActionButton: viewModel.status.openMenu ? null : IdtFab(homeSelect: true),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: _buildHome(viewModel)),
    );
  }

  Widget _buildHome(HomeViewModel viewModel) {
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();
    final size = MediaQuery.of(context).size;

    final _route = locator<IdtRoute>();
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
                itemCount: optionsHomeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => optionSelectedHome(index),
                      child: Container(
                        height: (size.height - 140) / optionsHomeList.length,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(IdtAssets.bogota_dc_travel),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              color: DataTest.colorsHomeList[index].withOpacity(0.4),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    optionsHomeList[index].toUpperCase(),
                                    style: TextStyle(
                                        color: IdtColors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black.withOpacity(0.9),
                                              offset: Offset(3, 2),
                                              blurRadius: 3),
                                        ]),
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
              SavedPlaces(
                  viewModel.status.openSaved,
                  viewModel.onpenSavedPlaces,
                  viewModel.status.notSaved,
                  viewModel.addSavedPLaces,
                  viewModel.status.seeAll,
                  viewModel.onTapSeeAll,
                  viewModel.onChangeScrollController,
                  scrollController,
                  viewModel.goDetailPage,
                  viewModel.status.itemsSavedPlaces),

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

  List<String> optionsHomeList = ['Descubre Bogotá', 'Eventos', '¿Dónde comer?', '¿Dónde Dormir?'];
}

// Container(
//   height: 140,
//   decoration: BoxDecoration(
//     color: Colors.red.withOpacity(0.4),
//   ),
//   child: Stack(
//     children: [
//       Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 optionsHome[index].toUpperCase(),
//                 style: TextStyle(
//                     color: IdtColors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold),shadows: [
//                                       Shadow(
//                                           color: Colors.black.withOpacity(0.7),
//                                           offset: Offset(3, 2),
//                                           blurRadius: 3),
//                                     ]
//               ),
//               Icon(
//                 IdtIcons.compass,
//                 color: Colors.white,
//                 size: 26,
//               ),
//             ],
//           ),
//         ),
//       )
//     ],
//   ),
// ),
