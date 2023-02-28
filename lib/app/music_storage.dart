import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../const/const_zip.dart';
import '../service/pl_item_controller.dart';

class MusicStorage extends GetView<PL_Items_Controller> {
  final String pLkey;

  const MusicStorage({super.key, required this.pLkey});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios, color: Colors.black87,),),
        title: Center(
            child: Text('음원 추가', style: TextStyle(color: Colors.black87, fontSize: 15))
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
                child: ListView.builder(
                    itemCount: musicData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Container(
                                  width: 450, height: 150,
                                  child: Row(
                                    children: [
                                      // 앨범 표지
                                      Image.network('${musicData[index].image}', width: 100, height: 100, fit: BoxFit.contain,),
                                      Container(
                                        width: 190, height: 150, padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              //노래 제목
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text('${musicData[index].title}'),
                                            ),
                                            Padding(
                                              //가수 이름
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text('${musicData[index].name}'),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // IconButton(onPressed: () => {
                                      //   //controller.updateIsChecked(index, false),
                                      // }, icon: const Icon(Icons.check_box, color: Colors.deepPurpleAccent, size: 20,))
                                      //체크박스

                                      Obx(() => controller.musicDataCheck[index].isChecked?
                                      IconButton(onPressed: () => {
                                        //controller.updateIsChecked(index, false),
                                      }, icon: const Icon(Icons.check_box, color: Colors.deepPurpleAccent, size: 20,))
                                          :
                                      IconButton(onPressed: ()=>{
                                        //controller.updateIsChecked(index, true),
                                      }, icon: const Icon(Icons.check_box_outline_blank, color: Colors.grey, size: 20,))),
                                    ],
                                  ),
                                ),

                                Divider(
                                  color: Colors.black.withOpacity(0.2),
                                  thickness: 1.0,
                                )
                              ],
                            ),
                            ),
                        ],
                      );
                    })
            ),



          ],
        ),
      ),

    );
  }

}