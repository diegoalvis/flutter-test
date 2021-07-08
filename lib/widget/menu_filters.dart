import 'package:auto_size_text/auto_size_text.dart';
import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenuFilter extends StatelessWidget {
  final VoidCallback closeMenu;
  final VoidCallback goFilters;
  final List<DataModel> listCategories;
  final List<DataModel> listSubcategories;
  final List<DataModel> listZones;
  final List<DataModel?> filter1;
  final List<DataModel?> filter2;
  final List<DataModel?> filter3;
  final String typeFilter;
  final Function(int, int, List<DataModel>) tapButton;
  late bool largeText;

  IdtMenuFilter({
    required this.closeMenu,
    required this.listCategories,
    required this.listSubcategories,
    required this.listZones,
    required this.goFilters,
    required this.filter1,
    required this.filter2,
    required this.filter3,
    required this.tapButton,
    required this.typeFilter,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 168),
      color: IdtColors.white.withOpacity(0.95),
      child: Container(
          color: IdtColors.transparent, height: double.infinity, child: _buildBody(textTheme)),
    );
  }

  SingleChildScrollView _buildBody(TextTheme textTheme) {
    Widget _filter(
        List<DataModel> listItems, Color color, List<Color> gradient, String title, int id) {
      final styleApp = StylesMethodsApp()
          .decorarStyle(gradient, 15, Alignment.bottomCenter, Alignment.topCenter);

      final styleAppWhite = BoxDecoration(color: IdtColors.white);

      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: textTheme.subTitleBlack.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 60,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                itemCount: listItems.length,
                itemExtent: 90,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(3),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: id == 1
                                    ? filter1[index] != null
                                        ? color
                                        : IdtColors.grayBtn
                                    : id == 2
                                        ? filter2[index] != null
                                            ? color
                                            : IdtColors.grayBtn
                                        : id == 3
                                            ? filter3[index] != null
                                                ? color
                                                : IdtColors.grayBtn
                                            : IdtColors.grayBtn,
                                width: 1),
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: 100.0, minWidth: 20, minHeight: 20.0, maxHeight: 40),
                          decoration: id == 1
                              ? filter1[index] != null
                                  ? styleApp
                                  : styleAppWhite
                              : id == 2
                                  ? filter2[index] != null
                                      ? styleApp
                                      : styleAppWhite
                                  : id == 3
                                      ? filter3[index] != null
                                          ? styleApp
                                          : styleAppWhite
                                      : null,
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            listItems[index].title!,
                            maxLines: 2,
                            wrapWords: false,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: textTheme.textButtomWhite.copyWith(
                              color: id == 1
                                  ? filter1[index] != null
                                      ? null
                                      : IdtColors.black.withOpacity(0.8)
                                  : id == 2
                                      ? filter2[index] != null
                                          ? null
                                          : IdtColors.black.withOpacity(0.8)
                                      : id == 3
                                          ? filter3[index] != null
                                              ? null
                                              : IdtColors.black.withOpacity(0.8)
                                          : null,
                            ),
                          ),
                        ),
                        onPressed: () => tapButton(index, id, listItems),
                      ),
                    )
                  ],
                ),
              ))
        ],
      );
    }

    List<Widget> listFilters = [];

    if (typeFilter != 'Zona') {
      listFilters
          .add(_filter(listZones, IdtColors.blue, IdtGradients.blue, 'Búsqueda por localidad', 2));
    }

    if (typeFilter != 'Producto') {
      listFilters.add(_filter(
          listSubcategories, IdtColors.orange, IdtGradients.orange, 'Búsqueda específica', 1));
    }
    if (typeFilter != 'Plan') {
      listFilters
          .add(_filter(listCategories, IdtColors.green, IdtGradients.green, 'Descubre Bogotá', 3));
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: IdtColors.orange,
                  size: 35,
                ),
                onPressed: closeMenu),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              ...listFilters,
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.all(1),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: IdtColors.blue, width: 1),
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 250.0, minWidth: 180, minHeight: 50.0, maxHeight: 50),
                      decoration: StylesMethodsApp().decorarStyle(
                          IdtGradients.blue, 30, Alignment.bottomCenter, Alignment.topCenter),
                      alignment: Alignment.center,
                      child: Text(
                        'Aplicar',
                        textAlign: TextAlign.center,
                        style: textTheme.textButtomWhite.copyWith(fontSize: 18),
                      )),
                  onPressed: goFilters,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
