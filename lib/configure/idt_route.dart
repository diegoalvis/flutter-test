import 'dart:ui';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/placesdetail_model.dart';
import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_page.dart';
import 'package:bogota_app/pages/detail/detail_page.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/event_detail/event_detail_page.dart';
import 'package:bogota_app/pages/events/events_page.dart';
import 'package:bogota_app/pages/filters/filters_page.dart';
import 'package:bogota_app/pages/home/home_page.dart';
import 'package:bogota_app/pages/login/login_page.dart';
import 'package:bogota_app/pages/play_audio/play_audio_page.dart';
import 'package:bogota_app/pages/profile/profile_page.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_page.dart';
import 'package:bogota_app/pages/register_user/register_user_page.dart';
import 'package:bogota_app/pages/result_search/result_search_page.dart';
import 'package:bogota_app/pages/saved_places/saved_places_page.dart';
import 'package:bogota_app/pages/search/search_page.dart';
import 'package:bogota_app/pages/setting/setting_page.dart';
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
    navigatorKey.currentState!.pop<T>(result);
  }

  void pop(){
    navigatorKey.currentState!.pop();
  }

  goHome(){
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (_)=> HomePage())
    );
  }

  goLogin(){
    return navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_)=> LoginPage())
    );
  }

  goRegister(){
    return navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_)=> RegisterUserPage())
    );
  }

  goRecoverPass(){
    return navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_)=> RecoverPassPage())
    );
  }

  goHomeRemoveAll(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> HomePage()),
      (Route<dynamic> route) => false
    );
  }

  goDetail({required bool isHotel, required DataPlacesDetailModel detail}){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> DetailPage(isHotel: isHotel, detail:detail))
    );
  }

  goPlayAudio(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> PlayAudioPage())
    );
  }

  goDiscover(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> DiscoverPage())
    );
  }

  goDiscoverUntil(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> DiscoverPage()),
      (route) => route.isFirst
    );
  } 

  goSearch(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> SearchPage())
    );
  }

  goSearchUntil(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> SearchPage()),
      (route) => route.isFirst
    );
  }

  goResultSearch(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> ResultSearchPage())
    );
  }

  goFilters({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
  }){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> FiltersPage(section, item, places, categories, subcategories, zones))
    );
  }

  goFiltersUntil({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
  }){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> FiltersPage(section, item, places, categories, subcategories, zones)),
      (route) => route.isFirst
    );
  }

  goAudioGuide(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> AudioGuidePage())
    );
  }

  goAudioGuideUntil(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> AudioGuidePage()),
      (route) => route.isFirst
    );
  }

  // goUnmissable(){
  //   return navigatorKey.currentState!.push(
  //     MaterialPageRoute(builder: (_)=> UnmissablePage())
  //   );
  // }

  goUnmissableUntil(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> UnmissablePage()),
      (route) => route.isFirst
    );
  }

  goEvents({required String title, String? nameFilter, required bool includeDay}){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> EventsPage(title: title, nameFilter: nameFilter, includeDay: includeDay,  ))
    );
  }

  goEventsDetail(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> EventDetailPage())
    );
  }

  goSleeps({required String title, String? nameFilter, required bool includeDay}){
    return navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (_)=> EventsPage(title: title, nameFilter: nameFilter, includeDay: includeDay))
    );
  }

  goSavedPlaces(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> SavedPlacesPage())
    );
  }

  goSavedPlacesUntil(){
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_)=> SavedPlacesPage()),
      (route) => route.isFirst
    );
  }

  goProfile(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> ProfilePage())
    );
  }

  goProfileEdit(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> ProfileEditPage())
    );
  }

  goSettings(){
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_)=> SettingPage())
    );
  }

  /*Future<dynamic> goRequestDetail(DataRequestModel dataRequestModel, DataRequestDetailModel requestDetail, DataRequestDetailDocumentsModel filesSolicitude){
    return navigatorKey.currentState.push(
        MaterialPageRoute(builder: (_)=> ReqDetailPage(dataRequestModel, requestDetail, filesSolicitude))
    );
  }*/
}