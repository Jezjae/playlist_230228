import 'dart:convert';
import 'package:flutter/services.dart';

import '../const/const_zip.dart';
import '../model/music_items_model.dart';

class MusicDataRepository{

  //json으로 저장된 음악데이터 정보 정리해서 리스트로 가져오기
  Future<List> getMusicJSONData() async {
    var jsonResponse = json.decode(
        await rootBundle.loadString('assets/music/music.json'));
    return jsonResponse;
  }

  List<MusicItemsModel> setMusicData() {
    List<MusicItemsModel> list = [];
    for(int j = 0; j < getMusicDataJson.length; j++)
      {
        MusicItemsModel musicItemsModel = MusicItemsModel(isChecked: false);
        musicItemsModel.id = getMusicDataJson[j]['id'];
        musicItemsModel.image  = getMusicDataJson[j]['image'];
        musicItemsModel.path  = getMusicDataJson[j]['path'];
        musicItemsModel.title = getMusicDataJson[j]['title'];
        musicItemsModel.name = getMusicDataJson[j]['name'];
        musicItemsModel.length = getMusicDataJson[j]['length'];
        musicItemsModel.isChecked = false;
        list.add(musicItemsModel);
      }
    return list; //매칭완료된 곡정보까지 들어간 선택곡 정보리스트
  }


}
MusicDataRepository  musicDataRepository =  MusicDataRepository();