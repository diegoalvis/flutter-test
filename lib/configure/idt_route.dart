import 'dart:ui';

import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/pages/%20recover_pass/recover_pass_page.dart';
import 'package:bogota_app/pages/activity/activity_page.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_page.dart';
import 'package:bogota_app/pages/detail/detail_page.dart';
import 'package:bogota_app/pages/discover/discover_page.dart';
import 'package:bogota_app/pages/event_detail/event_detail_page.dart';
import 'package:bogota_app/pages/events/events_page.dart';
import 'package:bogota_app/pages/events/events_view_model.dart';
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
import 'package:url_launcher/url_launcher.dart';

class IdtRoute {
  static final IdtRoute _singleton = IdtRoute._internal();

  factory IdtRoute() {
    return _singleton;
  }

  IdtRoute._internal();

  final navigatorKey = GlobalKey<NavigatorState>();

  void popT<T>(T result) {
    navigatorKey.currentState!.pop<T>(result);
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }

  goHome() {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
  }

  goLogin() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  goLoginAll() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginPage()), (Route<dynamic> route) => false);
  }

  goRegister() {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => RegisterUserPage()));
  }

  goRecoverPass() {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => RecoverPassPage()));
  }

  goHomeRemoveAll() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()), (Route<dynamic> route) => false);
  }

  goDetail({required bool isHotel, required DataPlacesDetailModel detail}) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => DetailPage(isHotel: isHotel, detail: detail)));
  }

  goPlayAudio({required DataPlacesDetailModel detail}) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => PlayAudioPage(detail: detail)));
  }

  goDiscover() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => DiscoverPage()));
  }

  goUserHome() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => HomePage()));
  }

  goDiscoverUntil() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => DiscoverPage()), (route) => route.isFirst);
  }

  goSearch() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SearchPage()));
  }

  goSearchUntil() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SearchPage()), (route) => route.isFirst);
  }

  goResultSearch(List<DataModel> results, String keyWord) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => ResultSearchPage(results, keyWord)));
  }

  goFilters({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
  }) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => FiltersPage(section, item, places, categories, subcategories, zones)));
  }

  goFiltersUntil({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
  }) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => FiltersPage(section, item, places, categories, subcategories, zones)),
        (route) => route.isFirst);
  }

  goAudioGuide() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => AudioGuidePage()));
  }

  goAudioGuideUntil() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => AudioGuidePage()), (route) => route.isFirst);
  }

  // goUnmissable(){
  //   return navigatorKey.currentState!.push(
  //     MaterialPageRoute(builder: (_)=> UnmissablePage())
  //   );
  // }

  goUnmissableUntil(int optionIndex) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => UnmissablePage(
                  optionIndex: optionIndex,
                )),
        (route) => route.isFirst);
  }

  goEvents(int optionIndex) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventsPage(
              type: SocialEventType.EVENT,
              optionIndex: optionIndex,
            )));
  }

  goEventDetail({required DataPlacesDetailModel detail}) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventDetailPage(
              detail: detail,
            )));
  }

  updateEventsZones({
    required DataModel item,
    // required List<DataModel> places,
    required List<DataModel> zones,
  }) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventsPage(type: SocialEventType.SLEEP,)));
  }


  goSleeps(int optionIndex) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventsPage(type: SocialEventType.SLEEP, optionIndex: optionIndex)));
  }

  goEat(int optionIndex) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventsPage(type: SocialEventType.EAT, optionIndex: optionIndex)));
  }

  goSavedPlaces() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SavedPlacesPage()));
  }

  goSavedPlacesUntil() {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SavedPlacesPage()), (route) => route.isFirst);
  }

  goPrivacyAndTerms() {
    return launch('https://bogotadc.travel/es/politica-tratamiento-datos-personales');
  }


  goProfile() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => ProfilePage()));
  }

  goProfileEdit(String emailUser,nameUser, String lastName) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => ProfileEditPage(emailUser,nameUser, lastName)));
  }

  goActivity() {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => ActivityPage()));
  }

  goSettings() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SettingPage()));
  }

/*Future<dynamic> goRequestDetail(DataRequestModel dataRequestModel, DataRequestDetailModel requestDetail, DataRequestDetailDocumentsModel filesSolicitude){
    return navigatorKey.currentState.push(
        MaterialPageRoute(builder: (_)=> ReqDetailPage(dataRequestModel, requestDetail, filesSolicitude))
    );
  }*/
}
