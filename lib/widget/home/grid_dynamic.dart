import 'dart:core';

import 'package:bogota_app/commons/idt_colors.dart';
import 'package:bogota_app/commons/idt_gradients.dart';
import 'package:bogota_app/data/DataTest.dart';
import 'package:bogota_app/pages/components/gradientIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../app_theme.dart';

class GridDynamic extends StatelessWidget {

  Widget SliderImages(BuildContext context) => (
    Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 0, top: 0),
          height: 180,
          width: 412,
          color: Colors.white,
          child: ListView.builder(
            itemCount: DataTest.imgList2.length,
            shrinkWrap: true,
            itemExtent: 150,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 12, right: 12, top: 17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topRight:
                          Radius.circular(15.00), // FLUTTER BUG FIX
                        ),
                        /*boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey[600],
                            offset: Offset(0, 0),
                            blurRadius: 11.0,
                          ),
                        ],*/
                      ),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 200,
                            width: 220,
                            color: Colors.white,
                            // margin: EdgeInsets.all(5),
                            child: Image.network(
                              DataTest.imgList[index],
                              height: 200,
                              width: 220,
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                      )
                    )
                  ],
                ),
                //     Image.network(imgList[index], fit: BoxFit.fill, width: 1000.0,height: 150,),

                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: IdtColors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    DataTest.textList[index],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            ),
            //  itemCount: imgList.length
          )
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.98,
          right: MediaQuery.of(context).size.width * 0.08,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20),
            child: IconButton(
              iconSize: 35,
              alignment: Alignment.centerLeft,
              icon: FittedBox(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.grey[900],
                  ),
                  onPressed: () {
                  },
                ),
              ), onPressed: () {  },
            ),
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.98,
          left: MediaQuery.of(context).size.width * 0.74,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 45),
            child: IconButton(
              iconSize: 35,
              alignment: Alignment.centerLeft,
              icon: FittedBox(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[900],
                  ),
                  onPressed: () {
                  },
                ),
              ), onPressed: () {  },
            ),
          ),
        )
      ],
    )
  );

  widget_row_buttons() => (
    Container(
      height: 45,
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: RaisedButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              splashColor: Colors.white,
              onPressed: () {
                print("Test");
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFF35A466), width: 1),
                borderRadius: BorderRadius.circular(80.0)
              ),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  /*gradient: LinearGradient(
                    colors: IdtStyles.greengradientcolor,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),*/
                  color: IdtColors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: 150.0,
                      minWidth: 150,
                      minHeight: 50.0,
                      maxHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "AUDIOGUÍAS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF35A466)
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            height: 50.0,
            child: RaisedButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              onPressed: () {

              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFF35A466), width: 1),
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: IdtGradients.green,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: 150.0,
                      minWidth: 150,
                      minHeight: 50.0,
                      maxHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "VER TODOS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )));

  Widget _textTitle(TextTheme textTheme) {

    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: [
              Text(
                "LUGARES GUARDADOS",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleBlack,
              ),
              Positioned(
                right: 12,
                child: IconButton(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  icon: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: IdtGradients.green,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Container(
                      child: GradientIcon(
                          icon: Icons.remove,
                          size: 25.0,
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.white,
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                      ),
                    ),
                  ),
                  onPressed: () {
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: StaggeredGridView.count(
        crossAxisCount: 6,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        staggeredTiles: _staggeredTiles,
        children: _tiles,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: EdgeInsets.all(4.0),
      ),
    );
      /*GridView.count(
      primary: false,
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("He'd have you all unravel at the"),
          color: Colors.teal[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Heed not the rabble'),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Sound of screams but the'),
          color: Colors.teal[300],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Who scream'),
          color: Colors.teal[400],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution is coming...'),
          color: Colors.teal[500],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('Revolution, they...'),
          color: Colors.teal[600],
        ),
      ],
    );*/
      /*Column(
      children: [
        SizedBox(height: 35),
        _textTitle(textTheme),
        SizedBox(height: 12),
        SliderImages(context),
        SizedBox(height: 10),
        widget_row_buttons(),
      ],
    );*/
  }
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(6, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile(Colors.green, Icons.widgets),
  const _Example01Tile(Colors.lightBlue, Icons.wifi),
  const _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
  const _Example01Tile(Colors.brown, Icons.map),
  const _Example01Tile(Colors.deepOrange, Icons.send),
  const _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
  const _Example01Tile(Colors.red, Icons.bluetooth),
  const _Example01Tile(Colors.pink, Icons.battery_alert),
  const _Example01Tile(Colors.purple, Icons.desktop_windows),
  const _Example01Tile(Colors.blue, Icons.radio),
  const _Example01Tile(Colors.green, Icons.widgets),
  const _Example01Tile(Colors.lightBlue, Icons.wifi),
  const _Example01Tile(Colors.amber, Icons.panorama_wide_angle),
  const _Example01Tile(Colors.brown, Icons.map),
  const _Example01Tile(Colors.deepOrange, Icons.send),
  const _Example01Tile(Colors.indigo, Icons.airline_seat_flat),
  const _Example01Tile(Colors.red, Icons.bluetooth),
  const _Example01Tile(Colors.pink, Icons.battery_alert),
  const _Example01Tile(Colors.purple, Icons.desktop_windows),
  const _Example01Tile(Colors.blue, Icons.radio),
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.iconData);

  final Color backgroundColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}