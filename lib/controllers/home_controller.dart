import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sinfpics2/models/pic.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  var modalOpened = false.obs;
  final objNameController = TextEditingController();
  final RxList pics = <Pic>[].obs;
  RxInt selectedPicIndex = 0.obs;

  @override
  void onInit() {
    objNameController.text = '';
    super.onInit();
  }

  @override
  void onClose() {
    objNameController.dispose();
    super.onClose();
  }

  clearFolder() {}
  loadPictures() {}
  Future getImage() async {
    // await Permission.storage.request();
    // if (await Permission.camera.request().isGranted) {
    //   var objName = objNameController.text;
    //   if (objName == "") {
    //     _showDialog("Objeto sem nome",
    //         "É preciso definir um nome para o objeto antes de tirar a foto.");
    //     return;
    //   }
    //   final pickedFile =
    //       await picker.getImage(source: ImageSource.camera, imageQuality: 1);
    //   var pic = await storageManager.movePicture(
    //       pickedFile.path, objNameController.text);
    //   setState(() {
    //     pics.add(pic);
    //   });
    //   print("Tirou foto");
    // }
  }
  vizualizePic() {}
  deletePic() {}
  renamePic() {}
}
