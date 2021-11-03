import 'dart:ui';

import 'package:bogota_app/data/model/audios_model.dart';
import 'package:bogota_app/data/model/data_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/model/user_model.dart';
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
import 'package:bogota_app/pages/play_audio_guia/play_audio_guia_page.dart';
import 'package:bogota_app/pages/profile/profile_page.dart';
import 'package:bogota_app/pages/profile_edit/profile_edit_page.dart';
import 'package:bogota_app/pages/register_user/register_user_page.dart';
import 'package:bogota_app/pages/result_search/result_search_page.dart';
import 'package:bogota_app/pages/saved_places/saved_places_page.dart';
import 'package:bogota_app/pages/search/search_page.dart';
import 'package:bogota_app/pages/select_language/select_language_page.dart';
import 'package:bogota_app/pages/setting/setting_page.dart';
import 'package:bogota_app/pages/unmissable/unmissable_page.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class IdtRoute {
  static final IdtRoute _singleton = IdtRoute._internal();
  static String route = '';

  factory IdtRoute() {
    return _singleton;
  }

  IdtRoute._internal();

  final navigatorKey = GlobalKey<NavigatorState>();

  void popT<T>(T result) {
    navigatorKey.currentState!.pop<T>(result);
  }

  void pop() {
    IdtRoute.route = '';
    navigatorKey.currentState!.pop();
  }
  goSelectLanguage() {

    // IdtRoute.route = HomePage.namePage;
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => SelectLanguagePage()));
  }


  goHome() {
    IdtRoute.route = HomePage.namePage;
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
    if(IdtRoute.route != HomePage.namePage){
      IdtRoute.route = HomePage.namePage;
      return navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()), (Route<dynamic> route) => false);

    }
  }

  goDetail({required bool isHotel, required DataPlacesDetailModel detail}) {

    if(IdtRoute.route != DetailPage.namePage){
      IdtRoute.route = "";
      return navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (_) => DetailPage(isHotel: isHotel, detail: detail)));
    }


  }


  goDetailAudio({required bool isHotel, required AudiosModel detail}) {

    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => PlayAudioGuiaPage(detail: detail)));
  }


  goPlayAudio({required DataPlacesDetailModel detail}) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => PlayAudioPage(detail: detail)));
  }

  goNewPlayAudio({required AudiosModel detail}) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => PlayAudioGuiaPage(detail: detail)));
  }

  goDiscover() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => DiscoverPage()));
  }

  goUserHome() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => HomePage()));
  }

  goDiscoverUntil() {
    if (IdtRoute.route != DiscoverPage.namePage){
      IdtRoute.route = DiscoverPage.namePage;
      return navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => DiscoverPage()), (route) => route.isFirst);
    }
  }

  goSearch() { //No usada
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SearchPage()));
  }

  goSearchUntil() {
    if(IdtRoute.route != SearchPage.namePage){
      IdtRoute.route = SearchPage.namePage;
      return navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => SearchPage()), (route) => route.isFirst);
    }
  }

  goResultSearch(List<DataModel> results, String keyWord) {
    if (IdtRoute.route != ResultSearchPage.namePage){
      IdtRoute.route = ResultSearchPage.namePage;
      return navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (_) => ResultSearchPage(results, keyWord)));
    }
  }

  goFilters({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
    required Map oldFilters,
  }) {
    if(IdtRoute.route != FiltersPage.namePage){
      IdtRoute.route = FiltersPage.namePage;
      return navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => FiltersPage(section, item, places, categories, subcategories, zones, oldFilters)));
    }
  }

  goToHomeChangelanguage({
    required String section,
    required DataModel item,
    required List<DataModel> places,
    required List<DataModel> categories,
    required List<DataModel> subcategories,
    required List<DataModel> zones,
    required Map oldFilters,
  }) {
    if(IdtRoute.route != FiltersPage.namePage){
      IdtRoute.route = FiltersPage.namePage;
      return navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => FiltersPage(section, item, places, categories, subcategories, zones, oldFilters)));
    }
  }


  goAudioGuide() {
    if(IdtRoute.route != AudioGuidePage.namePage){
      IdtRoute.route = AudioGuidePage.namePage;
      return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => AudioGuidePage()));
    }
  }

  goAudioGuideUntil(int optionIndex) {// no se usa
    if(IdtRoute.route != AudioGuidePage.namePage){
      IdtRoute.route = AudioGuidePage.namePage;
      return navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => AudioGuidePage(
            optionIndex: optionIndex,
          )), (route) => route.isFirst);
    }
  }

  // goUnmissable(){
  //   return navigatorKey.currentState!.push(
  //     MaterialPageRoute(builder: (_)=> UnmissablePage())
  //   );
  // }

  goUnmissableUntil(int optionIndex) {
    if(IdtRoute.route != UnmissablePage.namePage){
      IdtRoute.route = UnmissablePage.namePage;
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => UnmissablePage(
                  optionIndex: optionIndex,
                )),
        (route) => route.isFirst);
    }
  }

  goEvents(int optionIndex) {

    if (IdtRoute.route != 'events_page') {
      IdtRoute.route = 'events_page';
      return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
          builder: (_) =>
              EventsPage(
                type: SocialEventType.EVENT,
                optionIndex: optionIndex,
              )
      ),(route)=>route.isFirst);
     }
  }
  goEventDetail({required DataPlacesDetailModel detail}) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => EventDetailPage(
              detail: detail,
            )));
  }


  goSleeps(int optionIndex) {
    if(IdtRoute.route != 'sleep_page'){
      IdtRoute.route = 'sleep_page';
      return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
          builder: (_) =>
              EventsPage(
                type: SocialEventType.SLEEP,
                optionIndex: optionIndex,
              )
      ),(route)=>route.isFirst);
    }
  }

  goEat(int optionIndex) {
    if(IdtRoute.route != 'eat_page'){
      IdtRoute.route = 'eat_page';
      return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(
          builder: (_) =>
              EventsPage(
                type: SocialEventType.EAT,
                optionIndex: optionIndex,
              )
      ),(route)=>route.isFirst);
    }
  }

  goSavedPlaces() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SavedPlacesPage()));
  }

  goSavedPlacesUntil() {
    if(IdtRoute.route != SavedPlacesPage.namePage){
      IdtRoute.route = SavedPlacesPage.namePage;
      return navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => SavedPlacesPage()), (route) => route.isFirst);
    }
  }

  goPrivacyAndTerms() {
    return launch('https://bogotadc.travel/es/politica-tratamiento-datos-personales');
  }


  goProfile() {
    return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => ProfilePage()));
  }

  goProfileEdit(UserModel user) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (_) => ProfileEditPage(user)));
  }

  goActivity() {
    if (IdtRoute.route != ActivityPage.namePage){
      IdtRoute.route = ActivityPage.namePage;
      return navigatorKey.currentState!
          .push(MaterialPageRoute(builder: (_) => ActivityPage()));
    }

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
