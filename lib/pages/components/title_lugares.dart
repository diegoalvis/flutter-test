import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/pages/components/gradientIcon.dart';
import 'package:flutter/material.dart';
import 'package:bogota_app/widget/style_method.dart';

class Title_Lugares extends StatelessWidget {
  final stylemethod = StylesMethodsApp();
  final ic = GradientIcon();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 0),
        color: Colors.white,
        child: Row(
          //  crossAxisAlignment: CrossAxisAlignment.baseline,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
            Container(
              //height: 30,
              //  color: Colors.white,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  "LUGARES GUARDADOSS",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Expanded(
                child: IconButton(
              // iconSize: 40,
              //   mouseCursor: ,
              color: Colors.transparent,
              alignment: Alignment.centerRight,
              icon: Container(
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: IdtGradients.green,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(100.0)),
                child: Container(
                  child: ic.gradientIcon(
                    Icons.remove,
                    25.0,
                    LinearGradient(
                      colors: <Color>[
                        Colors.white,
                        Colors.white,
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              onPressed: () {
// do something
              },
            )),
          ],
        ),
      ),
    );
  }
}
