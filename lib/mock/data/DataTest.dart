import 'package:bogota_app/data/model/words_and_menu_images_model.dart';
import 'package:bogota_app/utils/local_data/box.dart';
import 'package:flutter/material.dart';





WordsAndMenuImagesModel dictionary = await BoxDataSesion.getDictionary();
mixin TitlesMenu {



  static String iniciarSesion = dictionary.appword7.toUpperCase();
  static String descubreBogota = dictionary.text_menu[0].toUpperCase();
  static String audioguias = dictionary.text_menu[4].toUpperCase();
  static String impedibles = dictionary.text_menu[5].toUpperCase();
  static String eventos = dictionary.text_menu[1].toUpperCase();
  static String dondeDormir = dictionary.text_menu[3].toUpperCase();
  static String dondeComer = dictionary.text_menu[2].toUpperCase();
  static String lugaresGuardados = dictionary.appword33.toUpperCase();
  static String privacidadYTerminos = '**-PRIVACIDAD Y TÉRMINOS';

}

class DataTest {
  DataTest._();

  static const List<String> imgList = [
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/sumapaz-4.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/_MG_0206%20%281%29.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Outlets-de-las-Am%C3%A9ricas_RicardoB%C3%A1ez-9.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/_MG_0206%20%281%29.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg'
  ];

  static const List<bool> boolList = [
    false,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    true,
    false,
    true,
    false,
    true
  ];

  static const List<String> imgListAudio = [
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/sumapaz-4.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/_MG_0206%20%281%29.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Outlets-de-las-Am%C3%A9ricas_RicardoB%C3%A1ez-9.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/DSC02240.jpg'
  ];

  static const List<bool> boolListAudio = [true, true, true, true, true, true];

  static const List<String> imgList2 = [
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/3/35/BOG_Iglesia_de_la_Tercera.JPG',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/%40_juan_santacruz_Jazz_al_Parque_2019_1-3.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/3/35/BOG_Iglesia_de_la_Tercera.JPG',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/%40_juan_santacruz_Jazz_al_Parque_2019_1-3.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
  ];

  static const List<String> textList = [
    'Parque Nacional Natural Sumapaz',
    'El Templo de San Francisco',
    'Hayuelos Centro Comercial y Empresarial',
    'Biblioteca Luis Ángel Arango',
    'Sendero Quebrada Las Delicias',
    'Museo del Oro',
    'Teatro Faenza',
    'Parque central',
    'Bogotá',
    'Parque central',
  ];

  static const List<String> textListAudio = [
    'El Templo de San Francisco',
    'Hayuelos Centro Comercial y Empresarial',
    'Museo del Oro',
    'Teatro Faenza',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
    'Parque central',
  ];

  static const List<String> textList2 = [
    'Parque Metropolitano Timiza - Villa del Río',
    'Centro Internacional',
    'Iglesia de La Tercera Orden',
    'Festival Internacional de Jazz',
    'Sendero Quebrada Las Delicias',
    'Museo del Oro',
    'Teatro Faenza',
    'Parque central',
    'Bogotá',
    'Parque central',
  ];

  static const List<String> imgList3 = [
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/3/35/BOG_Iglesia_de_la_Tercera.JPG',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/%40_juan_santacruz_Jazz_al_Parque_2019_1-3.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/_A0A3932whm.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/3/35/BOG_Iglesia_de_la_Tercera.JPG',
    'https://bogotadc.travel/drpl/sites/default/files/2020-09/%40_juan_santacruz_Jazz_al_Parque_2019_1-3.jpg',
  ];

  static const List<String> textList3 = [
    'Sendero Quebrada Las Delicias',
    'Museo del Oro',
    'Teatro Faenza',
    'Parque central',
    'Bogotá',
    'Parque central',
    'Parque Nacional Natural Sumapaz',
    'El Templo de San Francisco',
    'Hayuelos Centro Comercial y Empresarial',
    'Biblioteca Luis Ángel Arango',
  ];

  static const List<String> calificadoList = [
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Outlets-de-las-Am%C3%A9ricas_RicardoB%C3%A1ez-9.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Parque-Timiza_RicardoB%C3%A1ez-22.jpg',
    'https://bogotadc.travel/drpl/sites/default/files/2020-10/Outlets-de-las-Am%C3%A9ricas_RicardoB%C3%A1ez-9.jpg',
  ];

  static const List<String> textCalificadoList = [
    'Parque Nacional Natural Sumapaz',
    'El Templo de San Francisco',
    'Biblioteca Luis Ángel Arango',
    'Sendero Quebrada Las Delicias'
  ];

  static const List<Color> colorsHomeList = [
    Colors.deepOrange,
    Colors.yellow,
    Colors.green,
    Colors.lightBlueAccent,
    Colors.blueAccent,
    Colors.deepPurpleAccent
  ];

  static List<Map<String, dynamic>> List2(bool isLogged) {
    List<Map<String, dynamic>> menu = [];
    if (isLogged == false) {
      menu.add(
        {'title': TitlesMenu.iniciarSesion, 'value': 'login'},
      );
    }

    menu = [
      ...menu,
      ...[
        {'title': TitlesMenu.descubreBogota, 'value': 'discoverUntil'},
        {'title': TitlesMenu.audioguias, 'value': 'audioGuide'},
        {'title': TitlesMenu.impedibles, 'value': 'unmissableUntil'},
        {'title': TitlesMenu.eventos, 'value': 'events'},
        {'title': TitlesMenu.dondeDormir, 'value': 'sleeps'},
        {'title': TitlesMenu.dondeComer, 'value': 'eat'},
      ]
    ];

    if (isLogged == true) {
      menu.add(
        {'title': TitlesMenu.lugaresGuardados, 'value': 'savedPlacesUntil'},
      );
    }

    menu = [
      ...menu,
      ...[
        {'title': TitlesMenu.privacidadYTerminos, 'value': 'privacyAndTerms'},
      ]
    ];
    return menu;
  }

  static const List<String> List3 = ['Plan', 'Producto', 'Localidad', 'Audioguías'];
}
