import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../const/const_zip.dart';
import '../model/playlist_model.dart';



class PlayListNetworkRepository{

  //숨김이 아닌 플리 데이터 가져오기
  Future<List<PlayListModel>> getPlayListModel() async {
    final CollectionReference playListCollRef = FirebaseFirestore.instance.collection(PLAYLIST);
    List<PlayListModel> resultPlayList = [];
    QuerySnapshot querySnapshot = await playListCollRef.where(KEY_IS_HIDE, isEqualTo: false).get();

    querySnapshot.docs.forEach((element) {
      resultPlayList.add(PlayListModel.fromSnapshot(element));
    });
    return resultPlayList;
  }

  //숨김 플리 데이터 가져오기
  Future<List<PlayListModel>> getHidePlayListModel() async {
    final CollectionReference playListCollRef = FirebaseFirestore.instance.collection(PLAYLIST);
    List<PlayListModel> resultPlayList = [];
    QuerySnapshot querySnapshot = await playListCollRef.where(KEY_IS_HIDE, isEqualTo: true).get();

    querySnapshot.docs.forEach((element) {
      resultPlayList.add(PlayListModel.fromSnapshot(element));
    });
    return resultPlayList;
  }

  //관심목록 데이터 가져오기
  Future<List<PlayListModel>> getLikePlayListModel() async {
    final CollectionReference playListCollRef = FirebaseFirestore.instance.collection(PLAYLIST);
    List<PlayListModel> resultPlayList = [];
    QuerySnapshot querySnapshot = await playListCollRef.where(KEY_IS_FAV, isEqualTo: true).get();

    querySnapshot.docs.forEach((element) {
      resultPlayList.add(PlayListModel.fromSnapshot(element));
    });
    return resultPlayList;
  }

  //파이어베이스에 속 선택한 플레이 리스트 안에 들어가 있는 음악리스트 가져오기
  Future<List> getMyMusicData(String pLkey) async{
    final CollectionReference playListCollRef = FirebaseFirestore.instance.collection(PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc('$pLkey');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    List list = await documentSnapshot.get(KEY_MUSIC_LIST);
    return list;
  }

  //새 플리 추가하기
  void setPlayList(String title, bool fales) async {
    final CollectionReference playListCollRef = FirebaseFirestore.instance
        .collection(PLAYLIST);
    DocumentReference documentReference = playListCollRef.doc();

    final json = {
      KEY_TITLE: title,
      KEY_PLAYLISTKEY: documentReference.id,
      KEY_MUSIC_LIST: [],
      KEY_IS_FAV: fales,
      KEY_IS_HIDE: fales,
      KEY_IS_PLAY: fales,
    };
    await documentReference.set(json);
  }

  //좋아요 업데이트
  Future<String> updatePlayListFav(String playListKey, bool isFav) async{
    final DocumentReference playListRef = FirebaseFirestore.instance.collection(PLAYLIST).doc(playListKey);

    await FirebaseFirestore.instance.runTransaction((tx) async {
      tx.update(playListRef, {KEY_IS_FAV: isFav});
    });
    return playListKey;
  }

  //숨기기 업데이트
  void updatePlayListHide(String docID, bool isHide) {
    FirebaseFirestore.instance.collection(PLAYLIST).doc(docID).update({
      KEY_IS_HIDE: isHide,
    });
  }

  //플리 삭제하기
  Future<void> deletePlayList(String docID) async {
    await FirebaseFirestore.instance.collection(PLAYLIST).doc(docID).delete();
  }

  //플리 이름 수정하기
  void updatePlayListTitle(String docID, String title) {
    FirebaseFirestore.instance.collection(PLAYLIST).doc(docID).update({
      KEY_TITLE: title,
    });
  }

  //숨긴 플리 꺼내기 위해 수정하기
  void updatePlayListAll(String docId, bool isHide) {
    FirebaseFirestore.instance.collection(PLAYLIST).doc(docId).update(
        {KEY_IS_HIDE: isHide,});
  }

  //플리속 음악리스트 업데이트
  Future<void> updatePlayListMusicList(String docID, dynamic addMusic) async {
    await FirebaseFirestore.instance.collection(PLAYLIST).doc(docID).update({
      KEY_MUSIC_LIST: addMusic,
    });
  }

}

PlayListNetworkRepository playListNetworkRepository = PlayListNetworkRepository();
