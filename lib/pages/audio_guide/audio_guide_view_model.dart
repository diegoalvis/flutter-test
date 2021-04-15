import 'package:bogota_app/data/repository/interactor.dart';
import 'package:bogota_app/configure/idt_route.dart';
import 'package:bogota_app/pages/audio_guide/audio_guide_status.dart';
import 'package:bogota_app/utils/errors/unmissable_error.dart';
import 'package:bogota_app/utils/idt_result.dart';
import 'package:bogota_app/view_model.dart';

class AudioGuideViewModel extends ViewModel<AudioGuideStatus> {

  final IdtRoute _route;
  final ApiInteractor _interactor;

  AudioGuideViewModel(this._route, this._interactor) {
    status = AudioGuideStatus(
      isLoading: true,
      openMenu: false
    );
  }

  void onInit() async {
    //TODO
  }
/*  void getAudioGuideResponse() async {
    final audioguideResponse = await _interactor.getAudioGuidePlacesList();

    if (audioguideResponse is IdtSuccess<List<DataPlacesModel>?>) {
      status = status.copyWith(itemsAudioGuidePlaces: audioguideResponse
          .body); // Status reasignacion
      // status.places.addAll(UnmissableResponse.body)
    } else {
      final erroRes = audioguideResponse as IdtFailure<UnmissableError>;
      print(erroRes.message);
      UnimplementedError();
    }
    status = status.copyWith(isLoading: false);
  }*/
  void onpenMenu() {
    if (status.openMenu==false){
      status = status.copyWith (openMenu: true);
    }
    else{
      status = status.copyWith(openMenu: false);
    }
  }

  void closeMenu() {
    status = status.copyWith(openMenu: false);
  }

  void onTapDrawer(String type) async {
    status = status.copyWith(isLoading: true);
  }

  void goDetailPage() {
    _route.goDetail(isHotel: false);
  }
}
