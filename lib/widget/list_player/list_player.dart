import 'dart:ui';

import 'package:flutter/material.dart';

const double PADDING_HORIZONTAL = 10;
const double PROPORTIONS = 7;
const double PROPORTION_BOX_TEXTS = PROPORTIONS - 1;

class InfoListPlayer {
  String title;
  String subtitle;

  InfoListPlayer({
    required this.title,
    required this.subtitle,
  });
}

class ListPlayer extends StatefulWidget {
  List<InfoListPlayer> list;

  Color backgroundColor;
  Color color;

  ListPlayer({
    Key? key,
    required this.backgroundColor,
    required this.color,
    required this.list,
  }) : super(key: key);

  @override
  _ListPlayerState createState() => _ListPlayerState();
}

class _ListPlayerState extends State<ListPlayer> {
  Size? _size;

  int itemSelect = -1;

  @override
  Widget build(BuildContext context) {
    this._size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: PADDING_HORIZONTAL,
      ),
      child: Container(
        child: _generateList(),
      ),
    );
  }

  ListView _generateList() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (itemSelect != index) {
              itemSelect = index;
            } else {
              itemSelect = -1;
            }
            setState(() {});
          },
          child: ItemPlayer(
            index: index,
            totalItems: 5,
            backgroundColor: widget.backgroundColor,
            color: widget.color,
            select: itemSelect == index,
            item: InfoListPlayer(
              title: widget.list[index].title,
              subtitle: widget.list[index].subtitle,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 7,
      ),
      itemCount: widget.list.length,
    );
  }
}

class ItemPlayer extends StatelessWidget {
  InfoListPlayer item;
  Size? _size;
  bool select = false;

  int index;
  int totalItems;
  Color backgroundColor;
  Color color;
  ItemPlayer({
    Key? key,
    required this.item,
    required this.select,
    required this.index,
    required this.totalItems,
    required this.backgroundColor,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this._size = MediaQuery.of(context).size;
    final widthBoxText = ((_size!.width / PROPORTIONS) * PROPORTION_BOX_TEXTS) -
        (PADDING_HORIZONTAL * 2);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: _size!.width / PROPORTIONS,
            height: _size!.width / PROPORTIONS,
            child: Icon(
                this.select ? Icons.play_circle_filled : Icons.pause_circle,
                size: 40,
                color: this.color),
          ),
          Column(
            children: [
              _text(widthBoxText,
                  '${this.index + 1}/${this.totalItems} ${item.title}', 17),
              _text(widthBoxText, '${item.subtitle}', 13),
            ],
          )
        ],
      ),
    );
  }

  Container _text(double widthBoxText, String text, double size) {
    return Container(
      width: widthBoxText,
      padding: EdgeInsets.symmetric(
        horizontal: PADDING_HORIZONTAL,
        vertical: 2,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: this.color,
        ),
      ),
    );
  }
}


/**
 * Ejemplo de uso
 * Container(
            height: 400 ,
            child: ListPlayer(
              list: [
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
                InfoListPlayer(title: 'El casorio', subtitle: 'Cover'),
                InfoListPlayer(title: 'Si tu amor no vuelve', subtitle: 'Cover'),
                InfoListPlayer(title: 'Quien eres tú', subtitle: 'Cover'),
                InfoListPlayer(title: 'Perro intenso mix', subtitle: 'Cover'),
                InfoListPlayer(title: 'Podcast', subtitle: 'Cover'),
                InfoListPlayer(title: 'Paisaje', subtitle: 'Cover'),
              ],
              backgroundColor: Colors.black54,
              color: Colors.white,
            )
 */