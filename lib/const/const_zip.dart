
import 'package:flutter/cupertino.dart';
import '../model/music_items_model.dart';
import '../model/playlist_model.dart';

const PLAYLIST = 'playlist';
const KEY_PLAYLISTKEY = 'PlayListKey';
const KEY_TITLE = 'Title';
const KEY_MUSIC_LIST = 'MusicList';
const KEY_IS_FAV = 'IsFav';
const KEY_IS_HIDE = 'IsHide';
const KEY_IS_PLAY = 'IsPlay';



//입력창 텍스트 컨트롤러
final inputText = TextEditingController();

//입력된 텍스트 저장할 스트링
String? setTitle;

//전체 음악 가지고 오는 과정
List getMusicDataJson = [];

//가지고있는 전체 음악 담아줄 리스트
List<MusicItemsModel> musicData =[];

//팝업창이라 플리랑 버튼 통일을 위해 필요함
int playlistIndex = 0;
int prePlaylistIndex = 0;