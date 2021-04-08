import 'dart:async';

import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
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
      create: (_) =>
          HomeViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
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

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is HomeValueControllerScrollEffect) {
        scrollController.animateTo(
            event.next
                ? scrollController.offset + IdtConstants.itemSize
                : scrollController.offset - IdtConstants.itemSize,
            curve: Curves.linear,
            duration: Duration(milliseconds: event.duration));
      } else if (event is ShowDialogEffect) {
        context.showDialogObservation();
      }
    });
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
            viewModel.onpenMenu,
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
    );
  }

  Widget _buildHome(HomeViewModel viewModel) {
    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(closeMenu: viewModel.closeMenu)
          : SizedBox.shrink(),
    );
    final loading =
        viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SavedPlaces(
                  viewModel.status.openSaved,
                  viewModel.onpenSavedPlaces,
                  viewModel.status.notSaved,
                  viewModel.addSavedPLaces,
                  viewModel.status.seeAll,
                  viewModel.onTapSeeAll,
                  viewModel.onChangeScrollController,
                  scrollController,
                  viewModel.goDetailPage),
              SizedBox(height: 25),
              TextButton(
                child: Text('Enviar ubicacion'),
                onPressed: viewModel.setLocationUser,
              ),
              OtherPlaces(
                onTapCard: viewModel.goDetailPage,
                goDiscover: viewModel.goDiscoverPage,
                resUnmissable: viewModel.status.itemsUnmissablePlaces,
                resFood: viewModel.status.itemsFoodPlaces,
              )
            ],
          ),
        ),
        menu,
        loading,
      ],
    );
  }
}
