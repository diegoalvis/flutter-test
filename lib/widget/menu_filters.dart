import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/widget/style_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme.dart';

class IdtMenuFilter extends StatelessWidget {

  final VoidCallback closeMenu;
  final VoidCallback goFilters;
  final List listItems;

  IdtMenuFilter({
    required this.closeMenu,
    required this.listItems,
    required this.goFilters,
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 168),
      color: IdtColors.white.withOpacity(0.95),
      child: Container(
        color: IdtColors.transparent,
        height: double.infinity,
        child: _buildBody(textTheme)),
    );
  }

  SingleChildScrollView _buildBody(TextTheme textTheme) {

    Widget _filter (Color color, List<Color> gradient, String title){

      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: textTheme.subTitleBlack.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600
            ),
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
                          side: BorderSide(color: color, width: 1),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {  },
                      child: Container(
                          constraints: BoxConstraints(
                              maxWidth: 100.0,
                              minWidth: 20,
                              minHeight: 20.0,
                              maxHeight: 40
                          ),
                          decoration: StylesMethodsApp().decorarStyle(
                              gradient,
                              15,
                              Alignment.bottomCenter,
                              Alignment.topCenter
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Filtro 1',
                            textAlign: TextAlign.center,
                            style: textTheme.textButtomWhite,
                          )
                      ),
                      //onPressed: closeMenu,
                    ),
                  )
                ],
              ),
            )
          )
        ],
      );
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
              onPressed: closeMenu
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              _filter(IdtColors.orange, IdtGradients.orange, 'Busqueda específica'),
              _filter(IdtColors.blue, IdtGradients.blue, 'Busqueda por zona'),
              _filter(IdtColors.green, IdtGradients.green, 'Descubre Bogotá'),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: IdtColors.blue, width: 1),
                      borderRadius: BorderRadius.circular(80.0)
                  ),
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 250.0,
                          minWidth: 180,
                          minHeight: 50.0,
                          maxHeight: 50
                      ),
                      decoration: StylesMethodsApp().decorarStyle(
                          IdtGradients.blue,
                          30,
                          Alignment.bottomCenter,
                          Alignment.topCenter
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Aplicar',
                        textAlign: TextAlign.center,
                        style: textTheme.textButtomWhite.copyWith(
                          fontSize: 18
                        ),
                      )
                  ),
                  onPressed: closeMenu,
                ),
              )
            ],
          ),
          /*ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
            itemCount: listItems.length,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: closeMenu,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 30.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    child: Text(
                      ' ${listItems[index]}',
                      style: textTheme.textMenu
                    )
                  ),
                ),
              );
            },
            separatorBuilder: (context, posicion) {
              return Container(height: 1,);
            },
          )*/
        ],
      ),
    );
  }
}