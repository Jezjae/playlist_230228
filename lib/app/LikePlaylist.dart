import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../const/const_zip.dart';
import '../service/like_playlist_controller.dart';
import 'pl_items.dart';


class LikePlaylist extends GetView<LikePlayListController> {
  const LikePlaylist({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        //상단 가운데 텍스트
        title: Center(child: Text('관심목록', style: TextStyle(color: Colors.black87, fontSize: 15))),

      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 450,
                height: 660,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(()=> ListView.builder(
                    itemCount: controller.likePlayList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Column(
                          children: [
                            InkWell(
                              child: Container(
                                width: 430, height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 80, height: 80,
                                      child: Image.asset('assets/bom.png'), //플레이리스트 기본 표지
                                    ),
                                    Text('${controller.likePlayList[index].title}'),


                                    IconButton(onPressed: () => {
                                      controller.updateUnFav('${controller.likePlayList[index].playListKey}', index)
                                    }, icon: const Icon(Icons.favorite, color: Colors.deepPurpleAccent,)),

                                    //더보기 아이콘 (숨기기, 제목 수정하기, 삭제하기, 취소)
                                    IconButton(onPressed: (){
                                      showDialog(
                                        barrierDismissible: true, //외부터치시 팝업 사라짐
                                        context: context,
                                        builder: (BuildContext context) {
                                          //맞춤사이즈
                                          double width = MediaQuery.of(context).size.width;
                                          double height = MediaQuery.of(context).size.height;
                                          return AlertDialog(
                                              backgroundColor: Colors.transparent, //주변 화면 어둡게
                                              contentPadding: EdgeInsets.zero,
                                              elevation: 0.0,
                                              content: Column(
                                                mainAxisAlignment: MainAxisAlignment.end, //밑에서부터 정렬
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        const BorderRadius.all(Radius.circular(10.0))),
                                                    child: Column(
                                                      children: [
                                                        //숨기기 버튼
                                                        TextButton(onPressed: (){
                                                          controller.hidePL(context,'${controller.likePlayList[index].playListKey}');
                                                        }, child: Text('숨기기', style: TextStyle(fontSize: 20, color: Colors.deepPurple[300],),)),

                                                        Divider(), //구분선

                                                        //플리 이름 수정
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop(); //뒤로가기
                                                          showDialog(context: context,
                                                              barrierDismissible: true,//화면 빈공간 누르면 취소
                                                              builder: (BuildContext context){
                                                                return AlertDialog(
                                                                  backgroundColor: Colors.white,

                                                                  title: Text('플레이리스트 이름을 입력하세요'),
                                                                  content: Container(
                                                                    width: 200, height: 70, padding: EdgeInsets.all(10),
                                                                    child: TextField(controller: inputText,),),
                                                                  actions: [
                                                                    TextButton(onPressed: (){
                                                                      controller.updateTitle(context, '${controller.likePlayList[index].playListKey}');
                                                                    }, child: Text('확인'))
                                                                  ],
                                                                );
                                                              });
                                                        }, child: Text('수정하기', style: TextStyle(fontSize: 20, color: Colors.deepPurple[300],))),

                                                        Divider(),

                                                        //플리 삭제하기
                                                        TextButton(onPressed: (){
                                                          controller.delPL(context, '${controller.likePlayList[index].playListKey}');
                                                        },
                                                            child: Text('삭제하기', style: TextStyle(color: Colors.deepPurple[800], fontSize: 20),)),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox( //빈공간 띄우기
                                                    height: 10,
                                                  ),

                                                  //취소
                                                  Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        const BorderRadius.all(Radius.circular(10.0))),
                                                    child: Center(child: TextButton(onPressed: (){Navigator.of(context).pop();}, //뒤로가기
                                                        child: Text('취소', style: TextStyle(fontSize: 20, color: Colors.deepPurple[300],))),),
                                                  )
                                                ],
                                              ));
                                        },
                                      );
                                    }, icon: Icon(Icons.more_horiz, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              onTap: (){
                                Get.to(() => PL_Items(pLkey:'${controller.likePlayList[index].playListKey}'));
                              },
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                              thickness: 1.0,
                            )
                          ],
                        );
                    }))
            ),



          ],
        ),
      ),
    );
  }
}
