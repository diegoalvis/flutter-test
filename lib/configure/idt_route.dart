import 'package:bogota_app/pages/audio_guide/audio_guide_page.dart';
import 'package:bogota_app/pages/detail/detail_page.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/events/events_page.dart';
import 'package:bogota_app/pages/filters/filters_page.dart';
import 'package:bogota_app/pages/home_old/home.dart';
import 'package:bogota_app/pages/play_audio/play_audio_page.dart';
import 'package:bogota_app/pages/result_search/result_search_page.dart';
import 'package:bogota_app/pages/search/search_page.dart';
import 'package:bogota_app/pages/unmissable/unmissable_page.dart';
import 'package:flutter/material.dart';

class IdtRoute {

  static final IdtRoute _singleton = IdtRoute._internal();

  factory IdtRoute() {
    return _singleton;
  }

  IdtRoute._internal();

  final navigatorKey = GlobalKey<NavigatorState>();

  void popT<T>(T result){
    navigatorKey.currentState.pop<T>(result);
  }

  void pop(){
    navigatorKey.currentState.pop();
  }

  goHome(){
    return navigatorKey.currentState.pushReplacement(
      MaterialPageRoute(builder: (_)=> Home())
    );
  }

  goDetail(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> DetailPage())
    );
  }

  goPlayAudio(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> PlayAudioPage())
    );
  }

  goDiscover(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> DiscoverPage())
    );
  }

  goSearch(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> SearchPage())
    );
  }

  goResultSearch(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> ResultSearchPage())
    );
  }

  goFilters(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> FiltersPage())
    );
  }

  goAudioGuide(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> AudioGuidePage())
    );
  }

  goUnmissable(){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> UnmissablePage())
    );
  }

  goEvents({@required String title, String nameFilter, @required bool includeDay}){
    return navigatorKey.currentState.push(
      MaterialPageRoute(builder: (_)=> EventsPage(title: title, nameFilter: nameFilter, includeDay: includeDay))
    );
  }

  /*Future<dynamic> goRequestDetail(DataRequestModel dataRequestModel, DataRequestDetailModel requestDetail, DataRequestDetailDocumentsModel filesSolicitude){
    return navigatorKey.currentState.push(
        MaterialPageRoute(builder: (_)=> ReqDetailPage(dataRequestModel, requestDetail, filesSolicitude))
    );
  }*/
}