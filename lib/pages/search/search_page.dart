import 'dart:async';
import 'dart:ui';

import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/search/search_effect.dart';
import 'package:bogota_app/extensions/idt_dialog.dart';
import 'package:bogota_app/pages/search/search_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class SearchPage extends StatelessWidget {
  static final namePage = 'search_page';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SearchViewModel(locator<IdtRoute>(), locator<ApiInteractor>()),
      builder: (context, _) {
        return SearchWidget();
      },
    );
  }
}

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final keyWordController = TextEditingController();
  final scrollController = ScrollController();
  StreamSubscription<SearchEffect>? _effectSubscription;

  @override
  void initState() {
    final viewModel = context.read<SearchViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if (event is SearchValueControllerScrollEffect) {
        scrollController.animateTo(
            event.next
                ? scrollController.offset + IdtConstants.itemSize
                : scrollController.offset - IdtConstants.itemSize,
            curve: Curves.linear,
            duration: Duration(milliseconds: event.duration));
      } else if (event is ShowDialogEffect) {
        context.showDialogObservation(
            titleDialog: 'Sin resultados',
            bodyTextDialog:
                'No se han encotrado resultados para la busqueda especificada \n\n Intentalo de nuevo!',
            textPrimaryButton: 'aceptar / cerrar');
      }
    });

    // // una vez tengas la info la pasas aca
    // viewModel.onTapButton(index, id, items);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: viewModel.offMenuBack,
        child: Scaffold(
            appBar: IdtAppBar(viewModel.openMenu),
            backgroundColor: IdtColors.white,
            extendBody: true,
            floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
            bottomNavigationBar: viewModel.status.openMenu
                ? null
                : IdtBottomAppBar(discoverSelect: false, searchSelect: true),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: _buildDiscover(viewModel)),
      ),
    );
  }

  Widget _buildDiscover(SearchViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;
    final menu = AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: viewModel.status.openMenu
          ? IdtMenu(closeMenu: viewModel.closeMenu)
          : SizedBox.shrink(),
    );

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: IdtGradients.orange,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          )),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Icon(
                      Icons.search,
                      color: IdtColors.white,
                      size: 70,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                        onSubmitted: (value) {
                          viewModel.goResultSearchPage(value);
                        },
                        textInputAction: TextInputAction.search,
                        controller: keyWordController,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: IdtColors.white, fontSize: 20),
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          hintText: 'Buscar...',
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(color: IdtColors.white),
                          labelStyle: TextStyle(color: IdtColors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        )
                        //TODO: Arreglar los colores y estilos
                        ),
                  )
                ],
              ),
              SizedBox(height: 15),
              RaisedButton(
                  child: Text(
                    'Buscar',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  textColor: Colors.deepOrangeAccent,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () =>
                      viewModel.goResultSearchPage(keyWordController.text)
                  // viewModel.goResultSearchPage
                  )
            ],
          ),
        ),
        menu
      ],
    );
  }
}
