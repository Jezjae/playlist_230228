import 'package:cloud_firestore/cloud_firestore.dart';
import '../const/const_zip.dart';

class PlayListModel {

  String? playListKey;
  String? title;
  dynamic? musicList;
  bool isFav = false;
  bool isHide = false;
  bool isPlay = false;


  PlayListModel.fromMap(Map<String, dynamic> map)
      : playListKey = map[KEY_PLAYLISTKEY],
        title = map[KEY_TITLE],
        musicList = map[KEY_MUSIC_LIST],
        isFav = map[KEY_IS_FAV],
        isHide = map[KEY_IS_HIDE],
        isPlay = map[KEY_IS_PLAY];

  PlayListModel.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data() as Map<String, dynamic>);

}
