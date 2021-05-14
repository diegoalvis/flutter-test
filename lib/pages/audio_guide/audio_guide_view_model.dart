import 'package:bogota_app/data/model/audioguide_model.dart';
import 'package:bogota_app/data/model/places_detail_model.dart';
import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';
import 'package:flutter/cupertino.dart';

class AudioGuideViewModel extends ViewModel<AudioGuideStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  AudioGuideViewModel(this._route, this._interactor) {
    status = AudioGuideStatus(
      isLoading: true,
      openMenu: false,
      itemsAudioGuide:[]
    );
  }

  void onInit() async {
    status = status.copyWith(isLoading: true);
    print('entra audio');
    getAudioGuideResponse();
    //TODO
  }
void getAudioGuideResponse() async {
    final audioguideResponse = await _interactor.getAudioGuidesList();

    if (audioguideResponse is IdtSuccess<List<DataAudioGuideModel>?>) {
      print("model");
      print(audioguideResponse.body![0].audioguia_es);
      status = status.copyWith(itemsAudioGuide: audioguideResponse.body);
 /// Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = audioguideResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }

  void openMenu() {
    status = status.copyWith(openMenu: !status.openMenu);
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

   goDetailPage(String id) async {
     status = status.copyWith(isLoading: true);

     final placebyidResponse = await _interactor.getPlaceById(id);
     print('view model detail page');
     print(placebyidResponse);
     if (placebyidResponse is IdtSuccess<DataPlacesDetailModel?>) {
       print("model detail");
       print(placebyidResponse.body!.title);
       _route.goDetail(isHotel: false, detail: placebyidResponse.body!);
       /// Status reasignacion
       // status.places.addAll(UnmissableResponse.body)
     } else {
       final erroRes = placebyidResponse as IdtFailure<UnmissableError>;
       print(erroRes.message);
       UnimplementedError();
     }
     status = status.copyWith(isLoading: false);


  }
}
