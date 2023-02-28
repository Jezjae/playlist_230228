import 'package:get/get.dart';
import '../const/const_zip.dart';
import '../model/music_items_model.dart';
import '../repo/music_data_repository.dart';
import '../repo/play_list_network_repository.dart';

class PL_Items_Controller extends GetxController {

  late String pLkey;

  //싱글톤처럼 쓰기위함
  static PL_Items_Controller get to => Get.find();

  //데이터베이스에 있는 정보 가져와서 담을 리스트 선언
  RxList<dynamic> playListItemID = RxList<dynamic>();

  //데이터베이스 정보와 매칭된 음악세부정보를 담은 리스트
  RxList<MusicItemsModel> playListItems = RxList<MusicItemsModel>();

  //체크박스를 위한 전체음악 리스트
  RxList<MusicItemsModel> musicDataCheck = RxList<MusicItemsModel>();

  @override
  void onInit() async{

    //선택한 플리속 음원리스트 곡정보 하나씩 리스트에 담아줌
    await playListNetworkRepository.getMyMusicData(pLkey).then((value) => {
      playListItemID(value)
    });
    for(int i = 0; i < playListItemID.length; i++) //저장한 아이디
        {
      for(int j = 0; j < musicData.length; j++) //전체 곡정보
          {
        if(playListItemID[i] == musicData[j].id) //저장한 아이디와 전체곡정보속 같은 아이디만 찾아 리스트에 담음
            {
              playListItems.add(musicData[j]); //매칭완료된 곡정보까지 들어간 선택곡 정보리스트
        }
      }
    }

    //전체 음악리스트
    musicData = musicDataRepository.setMusicData();

    //체크박스 세팅
    musicDataCheck(musicData);

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

  void updateIsChecked(int index, bool value){
    musicDataCheck[index].isChecked = value;
    musicDataCheck.refresh();
  }

  void delMusicItems(context, int index){

    //곡 리스트에서 삭제
    for(int i = 0; i < playListItemID.length; i++)
    {
      if(i == index)
      {
        playListItemID.removeAt(i);
      }
    }

    //데이터베이스 수정
    playListNetworkRepository.updatePlayListMusicList(pLkey, playListItemID).then((value) => {

    });
  }




}

