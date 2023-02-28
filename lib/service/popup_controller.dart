
import 'package:get/get.dart';
import 'package:the_last_playlist/service/playlist_controller.dart';
import '../model/playlist_model.dart';

class PopupController extends GetxController {

  //싱글톤처럼 쓰기위함
  static PopupController get to => Get.find();

  //재생되고 있는 노래 정보
  RxString popupTitle = RxString('String title');
  RxString popupImage = RxString('String image');
  RxString popupName = RxString('String name');

  //재생, 일시정지
  RxBool isPlay = RxBool(false);

  //팝업창 유무 (재생, 멈춤)
  RxBool isPopup = RxBool(false);


  @override
  void onInit() async{
    super.onInit();
  }

  @override
  void onReady() async{
    super.onReady();
  }
  @override
  void onClose() {
    super.onClose();
  }


  set setPopupTitle(String title){
    popupTitle(title);
  }

  set setPopupImage(String image){
    popupImage(image);
  }

  set setPopupName(String name){
    popupName(name);
  }

  set setIsPopup(bool value){
    isPopup(value);
  }

  set setIsPlay(bool value){
    isPlay(value);
  }

  //일시정지 버튼 눌렀을때
  void updatePause(int index){
    setIsPlay = false; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    PlayListController.to.playList[index].isPlay = false;
    PlayListController.to.playList.refresh();
  }

  //플레이 버튼 눌렀을 때
  void updatePlay(int index){
    setIsPlay = true; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    setIsPopup = true; // 노래가 재생될 때 팝업창 띄워 주는 것

    setPopupImage = PlayListController.to.playList[index].title!;
    setPopupTitle = PlayListController.to.playList[index].title!;
    setPopupName = PlayListController.to.playList[index].title!;

    PlayListController.to.playList[index].isPlay = true;
    PlayListController.to.playList.refresh();
  }

  //플레이 스탑버튼 눌렀을때
  void updateStop(int index){
    setIsPlay = false; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    setIsPopup = false; // 노래가 재생될 때 팝업창 띄워 주는 것
    PlayListController.to.playList[index].isPlay = false;
    PlayListController.to.playList.refresh();
  }
}

