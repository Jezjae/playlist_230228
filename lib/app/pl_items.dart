
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../service/pl_item_controller.dart';
import 'music_storage.dart';

class PL_Items extends GetView<PL_Items_Controller> {
  final String pLkey;
  const PL_Items({super.key , required this.pLkey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //앱 상단부
      appBar: AppBar(
        backgroundColor: Colors.white,

        //앱 왼쪽 상단
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios, color: Colors.black87,),), //뒤로가기

        //앱 오른쪽 상단
        actions: [IconButton(onPressed: ()async{
          Get.to(() => MusicStorage(pLkey: pLkey,));

        }, icon: Icon(Icons.add, color: Colors.black87,))],

        //앱 중간 타이틀
        title: Center(
            child: Text('음원리스트', style: TextStyle(color: Colors.black87, fontSize: 15))
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 450,
                height: 660,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(()=>ListView.builder(
                    itemCount: controller.playListItems.length,
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
                                      child: Image.network('${controller.playListItems[index].image}', width: 100, height: 100, fit: BoxFit.contain,), //플레이리스트 기본 표지
                                    ),
                                    Container(
                                      width: 280, height: 100, padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 115, height: 150, padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  //노래제목
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('${controller.playListItems[index].title}'),
                                                ),
                                                Padding(
                                                  //가수이름
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text('${controller.playListItems[index].name}'),
                                                ),
                                              ],
                                            ),
                                          ),


                                          //더보기 버튼
                                          IconButton(onPressed: (){
                                            showDialog(
                                              barrierDismissible: true, //빈화면 누르면 취소
                                              context: context,
                                              builder: (BuildContext context) {
                                                //맞춤사이즈
                                                double width = MediaQuery.of(context).size.width;
                                                double height = MediaQuery.of(context).size.height;
                                                return AlertDialog(
                                                    backgroundColor: Colors.transparent, //뒷배경 어두운 불투명
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
                                                              //삭제하기
                                                              TextButton(onPressed: (){

                                                              },
                                                                  child: Text('플레이리스트에서 삭제하기', style: TextStyle(color: Colors.red, fontSize: 20),)),

                                                              Divider(),

                                                              TextButton(onPressed: (){Navigator.of(context).pop();}, //뒤로가기
                                                                  child: Text('취소', style: TextStyle(fontSize: 20)))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            );
                                          }, icon: Icon(Icons.more_horiz, color: Colors.grey))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.updatePopup(index);
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