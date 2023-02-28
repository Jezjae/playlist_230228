
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../const/const_zip.dart';
import '../service/popup_controller.dart';

class PlayPopup extends GetView<PopupController> {
  const PlayPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 5, left: 10, right: 10,
        child: Container(
          alignment: Alignment.center,
          width: 360, height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.deepPurple[200],),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //앨범표지
                  width: 70, height: 70, padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Obx(()=> Image.network('${controller.popupImage}', width: 100, height: 100, fit: BoxFit.contain,),),
                ),
                Container(
                  width: 100, height: 65, padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        //노래제목
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(()=> Text('${controller.popupTitle}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
                      ),
                      Padding(
                        //가수이름
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(()=> Text('${controller.popupName}')),
                      ),
                    ],
                  ),
                ),

                Obx(()=> controller.isPlay.value?
                IconButton(onPressed: (){
                  controller.updatePause(playlistIndex);
                }, icon: Icon(Icons.pause, color: Colors.white, size: 30)) :
                IconButton(
                  onPressed: () async{
                    controller.updatePlay(playlistIndex);
                  },
                  icon: Icon(Icons.play_arrow, size: 30, color: Colors.white,),
                )),

                IconButton(onPressed: (){
                  controller.updateStop(playlistIndex);
                }, icon: Icon(Icons.stop, size: 35, color: Colors.white),padding: EdgeInsets.fromLTRB(0, 0, 0, 0),),

              ],
            ),
            ],
          ),
        ));
  }

}
