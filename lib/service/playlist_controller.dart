
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_last_playlist/service/like_playlist_controller.dart';
import 'package:the_last_playlist/service/popup_controller.dart';
import '../const/const_zip.dart';
import '../model/playlist_model.dart';
import '../repo/play_list_network_repository.dart';

class PlayListController extends GetxController {

  //싱글톤처럼 쓰기위함
  static PlayListController get to => Get.find();

  //데이터베이스에 있는 정보 가져와서 담을 리스트 선언
  RxList<PlayListModel> playList = RxList<PlayListModel>();

  @override
  void onInit() async{
    await playListNetworkRepository.getPlayListModel().then((value) => {
      playList(value)
    });
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

  //일시정지 버튼 눌렀을때
  void updatePause(int index){
    playlistIndex = index;
    PopupController.to.setIsPlay = false; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    playList[index].isPlay = false;
    playList.refresh();
  }

  //플레이 버튼 눌렀을 때
  void updatePlay(int index){
    playlistIndex = index;
    PopupController.to.setIsPlay = true; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    PopupController.to.setIsPopup = true; // 노래가 재생될 때 팝업창 띄워 주는 것

    //PopupController.setPopupImage = playList[index].title!;
    PopupController.to.setPopupTitle = playList[index].title!;
    PopupController.to.setPopupName = playList[index].title!;

    playList[index].isPlay = true;
    playList.refresh();
  }

  //플레이 스탑버튼 눌렀을때
  void updateStop(int index){
    playlistIndex = index;
    PopupController.to.setIsPlay = false; //팝업창의 플레이:퓨즈 로 바꿔주는 것
    PopupController.to.setIsPopup = false; // 노래가 재생될 때 팝업창 띄워 주는 것
    playList[index].isPlay = false;
    playList.refresh();
  }

  //좋아요 업데이트
  void updateFav(String plKey, int index) async {
    await playListNetworkRepository.updatePlayListFav(plKey, true).then((value) async =>
    {
      playList[index].isFav = true,
      playList.refresh(),

      LikePlayListController.to.likePlayList.add(playList[index]),
    });
  }
  void updateUnFav(String plKey, int index) async {
    await playListNetworkRepository.updatePlayListFav(plKey, false).then((value) async =>
    {
      playList[index].isFav = false,
      playList.refresh(),

      LikePlayListController.to.likePlayList.remove(playList[index]),
    });
  }

  //새 플리 추가
  void addNewPlaylist(context) async{
    setTitle = inputText.text;
    //이름빈칸예외처리
    if(setTitle == '') { }
    else
    {
      //정한 이름 데이터베이스에 넣고 초기화
      playListNetworkRepository.setPlayList(setTitle!, false);
      playList(await playListNetworkRepository.getPlayListModel());
      inputText.text = '';
      playList.refresh();
      Navigator.of(context).pop();
    }
  }

  //플리 숨기기
  void hidePL(context, String plKey) async{
    Navigator.of(context).pop(); //뒤로가기
    playListNetworkRepository.updatePlayListHide(plKey, true); //데이터베이스에 업데이트
    // tempId.add(plKey); //다시 불러오기 위한 id저장
    playList(await playListNetworkRepository.getPlayListModel());
    playList.refresh(); //플리데이터와 플리리스트 동기화
  }

  //숨긴 플리 꺼내기
  void showAllPL(context) async{
    Navigator.of(context).pop();

    //숨긴 플리의 데이터 키 값 저장하는 것 (숨기고 불러오기 위해서)
    List<PlayListModel> tempId = [];
    await playListNetworkRepository.getHidePlayListModel().then((value) => {
      tempId = value
    });

    for (int i = 0; i < tempId.length; i++)
      playListNetworkRepository.updatePlayListAll('${tempId[i].playListKey}', false);

    playList(await playListNetworkRepository.getPlayListModel());
    playList.refresh();
  }

  //플리 삭제
  void delPL(context, String plKey) {
    Navigator.of(context).pop(); //뒤로가기

    //데이터베이스에서 삭제후 리스트 동기화
    playListNetworkRepository.deletePlayList(plKey).then((value) async =>
    {
      playList(await playListNetworkRepository.getPlayListModel()),
      playList.refresh() //플리데이터와 플리리스트 동기화
    });
  }

  //플리 이름 수정
  Future<void> updateTitle(context, String plKey) async {
    setTitle = inputText.text;

    //이름빈칸예외처리
    if (setTitle == '') {}
    else {
      //정한 이름 데이터베이스에 넣고 초기화
      playListNetworkRepository.updatePlayListTitle(plKey, '$setTitle');
      inputText.text = '';
      playList(await playListNetworkRepository.getPlayListModel());
      playList.refresh(); //플리데이터와 플리리스트 동기화
      Navigator.of(context).pop();
    }
  }

}

