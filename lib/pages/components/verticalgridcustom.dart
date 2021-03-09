import 'package:bogota_app/commons/idt_assets.dart';
import 'package:bogota_app/commons/idt_icons.dart';
import 'package:bogota_app/pages/components/icongrad.dart';
import 'package:flutter/material.dart';

class GridVerticalCustom_Component extends StatelessWidget {
  @override

  // GridVertical_Component createState() => GridVertical_Component();
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget GridVerticalCustom(
      BuildContext context, imgList2, textList2, int type) {
    //type 1 muestra audioguías, 2 muestra imperdibles (sin ícono de headphones
    // final ic= GradientIcon();

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0.0,
          crossAxisCount: 2,
          // childAspectRatio: 1.5,
          childAspectRatio: (MediaQuery.of(context).size.width / 1.5) /
              (MediaQuery.of(context).size.height / 3.6)
          //       childAspectRatio: MediaQuery.of(context).size.width /(MediaQuery.of(context).size.height / 2.9),
          ),
      delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
                margin: EdgeInsets.only(
                    left: index % 2 == 0 ? 40 : 3,
                    right: index % 2 != 0 ? 40 : 3,
                    top: 5,
                    bottom: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 1.0, top: 1.0, right: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(const Radius.circular(12.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.black,
                      ),

                      // color: Colors.white,
                      //     height: 100,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 0.0),
                          child: Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: 0.7,
                                child: SizedBox(
                                  child: Image.network(
                                    imgList2[index],
                                    height: 180,
                                    // width: 150,
                                    //   width: 150,
                                    fit: BoxFit.fill,

                                    // fit: BoxFit.cover, width: 1000.0
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                left: MediaQuery.of(context).size.width *0.32,
                                child: Container(),
                              ),
                              type == 1 ? widget_audioguias() : Container(),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(0, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    //'Lugar No.  ' +,
                                    textList2[index],
                                    maxLines: 2,
                                    // '',
                                    //   overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                      shadows: <Shadow>[
                                        Shadow(
                                            color: Colors.white,
                                            blurRadius: 0,
                                            offset: Offset(0.5, 0.1)),
                                        Shadow(
                                            color: Colors.white,
                                            blurRadius: 0,
                                            offset: Offset(0.5, 0.1)),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          childCount: imgList2.length),
    );
  }

  widget_audioguias() {
    return Positioned(
      top: 10.0,
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            height: 40,
            width: 85,
            decoration: BoxDecoration(

            ),
            //  child: IconShadowWidget(Icon(Bogota_icon.headphones,
            //      color: Colors.white, size: 36),shadowColor: Colors.transparent,),
          ),
        ),
      ),
    );
  }
}
