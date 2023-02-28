import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_last_playlist/repo/music_data_repository.dart';
import 'package:the_last_playlist/service/like_playlist_controller.dart';
import 'package:the_last_playlist/service/pl_item_controller.dart';
import 'package:the_last_playlist/service/playlist_controller.dart';
import 'package:the_last_playlist/service/popup_controller.dart';
import 'app/home_view.dart';
import 'const/const_zip.dart';
import 'firebase_options.dart';


void main() async{

  //비동기로 데이터를 다룬다음 runapp할 경우 사용
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //getx setup
  Get.put(PlayListController());
  Get.put(LikePlayListController());
  Get.put(PL_Items_Controller());
  Get.put(PopupController());


  //음악정보 리스트에 담아주기
  getMusicDataJson = await musicDataRepository.getMusicJSONData();
  musicData = musicDataRepository.setMusicData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '플레이리스트 만들기',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeView(),
    );
  }
}