

import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'recover_pass_view_model.dart';

class RecoverPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RecoverPassViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return RecoverPassWidget();
      },
    );
  }
}

class RecoverPassWidget extends StatefulWidget {
  @override
  _RecoverPassWidgetState createState() => _RecoverPassWidgetState();
}

class _RecoverPassWidgetState extends State<RecoverPassWidget> {

  final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RecoverPassViewModel>().onInit();
    });

    final viewModel = context.read<RecoverPassViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecoverPassViewModel>();

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
              // TextButton(
              //   child: Text('Enviar ubicacion'),
              //   onPressed: viewModel.setLocationUser,
              // ),
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
