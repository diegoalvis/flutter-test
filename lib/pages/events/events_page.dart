import 'dart:html';
import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:bogota_app/commons/idt_constants.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/configure/get_it_locator.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/events/events_view_model.dart';
import 'package:bogota_app/widget/appbar.dart';
import 'package:bogota_app/widget/bottom_appbar.dart';
import 'package:bogota_app/widget/fab.dart';
import 'package:bogota_app/widget/idt_progress_indicator.dart';
import 'package:bogota_app/widget/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';


class EventsPage extends StatelessWidget {
  final String title;
  final String? nameFilter;
  final bool includeDay;
  final SocialEventType type;

  EventsPage({required this.title, this.nameFilter, required this.includeDay, required this.type});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsViewModel(locator<IdtRoute>(), locator<ApiInteractor>(), type),
      builder: (context, _) {
        return EventsWidget(title, nameFilter, includeDay);
      },
    );
  }
}

class EventsWidget extends StatefulWidget {
  // final String _title;
  final String? _nameFilter;
  // final bool _includeDayeDay;
  final eventType type;

  EventsWidget(this._title, this._nameFilter, this._includeDay);

  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<EventsViewModel>().onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EventsViewModel>();

    return SafeArea(
      child: Scaffold(
          appBar: IdtAppBar(viewModel.onpenMenu),
          backgroundColor: IdtColors.white,
          extendBody: true,
          extendBodyBehindAppBar: true,
          floatingActionButton: viewModel.status.openMenu ? null : IdtFab(),
          bottomNavigationBar: viewModel.status.openMenu ? null : IdtBottomAppBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: _buildDiscover(viewModel)),
    );
  }

  Widget _buildDiscover(EventsViewModel viewModel) {
    final loading = viewModel.status.isLoading ? IdtProgressIndicator() : SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;

    final menu = viewModel.status.openMenu
        ? Padding(
            padding: EdgeInsets.only(top: 70),
            child: IdtMenu(closeMenu: viewModel.closeMenu, optionIndex: 4,),
          )
        : SizedBox.shrink();

    final menuTap =
        /*viewModel.status.openMenuTab ?
      IdtMenuTap(
        listItems: widget._includeDay ? listMenuEvent : listMenu,
        closeMenu: viewModel.closeMenuTab,
        isBlue: true,
        goFilters: viewModel.closeMenuTab,
      )
      :*/
        SizedBox.shrink();

    Widget _buttonFilter() {
      return Row(
        children: [
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              color:
                  viewModel.status.openMenuTab ? IdtColors.white : IdtColors.blue.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: IdtColors.grayBtn, width: 0.5),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  )),
              onPressed: viewModel.onpenMenuTab,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget._nameFilter?.toUpperCase() ?? 'TODOS',
                            textAlign: TextAlign.center,
                            style: textTheme.textDetail
                                .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  Positioned(
                      right: 15,
                      child: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: IdtColors.blue,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget imagesCard(String image, int index, List listItems, String namePlace, String dayOfMonth,
            String month) =>
        (Center(
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap:
                    widget.type == eventType.EVENT ? viewModel.goDetailEventPage : viewModel.goDetailPageHotel,
                child: ClipRRect(
                  borderRadius:
                      // Validacion para el borde superior izquiero
                      (index == 0)
                          ? BorderRadius.only(topLeft: Radius.circular(15))

                          // Validacion para el borde superior derecho
                          : (index == 2)
                              ? BorderRadius.only(topRight: Radius.circular(15))

                              // Validaciones para el borde inferior izquiero
                              : (index == (listItems.length - 3) && index % 3 == 0)
                                  ? BorderRadius.only(bottomLeft: Radius.circular(15))
                                  : (index == (listItems.length - 2) && index % 3 == 0)
                                      ? BorderRadius.only(bottomLeft: Radius.circular(15))
                                      : (index == (listItems.length - 1) && index % 3 == 0)
                                          ? BorderRadius.only(bottomLeft: Radius.circular(15))

                                          // Validacion para el borde inferior derecho
                                          : (index == (listItems.length - 1) &&
                                                  (index + 1) % 3 == 0)
                                              ? BorderRadius.only(bottomRight: Radius.circular(15))
                                              : BorderRadius.circular(0.0),
                  child: SizedBox(
                    child: Image.network(
                      image,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    padding: widget._includeDay
                        ? EdgeInsets.only(left: 10.0)
                        : EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(namePlace.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: widget._includeDay ? TextAlign.right : TextAlign.center,
                              style: textTheme.textWhiteShadow.copyWith(fontSize: 11)),
                        ),
                        widget._includeDay
                            ? Expanded(
                          flex: 2,
                          child: Container(
                                  margin: EdgeInsets.only(left: 3),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(colors: IdtGradients.orange),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                      )),
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    children: [
                                      Text(dayOfMonth,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: textTheme.textButtomWhite
                                              .copyWith(fontSize: 16, )),
                                      Text(month,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: textTheme.textButtomWhite.copyWith(fontSize: 18,fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    )),
              ),
            ],
          ),
        ));

    Widget gridImagesCol3(List<DataModel> listItems) => (GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 5,
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: listItems.asMap().entries.map((entry) {
            final int index = entry.key;
            final imageUrl = entry.value.coverImage ?? '';
            final String image = IdtConstants.url_image + imageUrl;
            final String namePlace = entry.value.title ?? '';
            initializeDateFormatting();
            final String dateMmmDdd =
                DateFormat('MMMd','es' ).format(DateTime.parse('2021-01-11T16:27:45')); //entry.value.date
            List separatedDate = dateMmmDdd.split(" ");

            return imagesCard(
                image, index, listItems, namePlace, separatedDate[0], separatedDate[1]);
          }).toList(),
        ));

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
              _buttonFilter(),
              SizedBox(height: 30),
              gridImagesCol3(viewModel.status.itemsEventPlaces), //viewModel.status.itemsEventPlaces
              SizedBox(height: 55),
            ],
          ),
        ),
        loading,
        menu,
        menuTap,
      ],
    );
  }
}
