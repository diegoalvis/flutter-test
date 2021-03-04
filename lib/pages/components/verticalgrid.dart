import 'package:flutter/material.dart';

class GridVertical_Component extends StatelessWidget {
  @override

  // GridVertical_Component createState() => GridVertical_Component();
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget GridVertical(BuildContext context, imgList2, textList2) {

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0.5,
          crossAxisCount: 2,
          // childAspectRatio: 1.5,
          childAspectRatio: (MediaQuery.of(context).size.width / 1.5) /
              (MediaQuery.of(context).size.height / 3.4)
          //       childAspectRatio: MediaQuery.of(context).size.width /(MediaQuery.of(context).size.height / 2.9),
          ),
      delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 1.5, right: 2),
                child: ClipRRect(
                  borderRadius: (index == 0)
                      ? BorderRadius.only(topLeft: const Radius.circular(12.0))
                      : (index == 1)
                          ? BorderRadius.only(
                              topRight: const Radius.circular(12.0))
                          : (index == imgList2.length - 2)
                              ? BorderRadius.only(
                                  bottomLeft: const Radius.circular(12.0))
                              : (index == (imgList2.length - 1))
                                  ? BorderRadius.only(
                                      bottomRight: const Radius.circular(12.0))
                                  : BorderRadius.circular(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              child: Image.network(
                                imgList2[index],
                                height: 190,
                                fit: BoxFit.fill,
                              ),
                            ),
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
                                  textList2[index].toUpperCase(),
                                  maxLines: 2,
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
          childCount: imgList2.length),
    );
  }
}
