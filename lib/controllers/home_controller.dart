import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sinfpics2/models/pic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sinfpics2/services/storage_manager.dart';

class HomeController extends GetxController {
  var modalOpened = false.obs;
  final objNameController = TextEditingController();
  final RxList pics = <Pic>[].obs;
  final StorageManager storageManager = StorageManager();
  RxInt selectedPicIndex = 0.obs;
  final picker = ImagePicker();

  @override
  void onInit() {
    objNameController.text = '';
    super.onInit();
    storageManager.init();
    loadPictures();
  }

  @override
  void onClose() {
    objNameController.dispose();
    super.onClose();
  }

  clearFolder() {}
  loadPictures() {}
  Future getImage() async {
    await Permission.storage.request();
    if (await Permission.camera.request().isGranted) {
      var objName = objNameController.text;
      if (objName == "") {
        Get.defaultDialog(
          title: "Objeto sem nome",
          middleText:
              "É preciso definir um nome para o objeto antes de tirar a foto.",
          backgroundColor: Colors.green,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
        );
        return;
      }
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 1);
      if (pickedFile != null) {
        var pic = await storageManager.movePicture(
            pickedFile.path, objNameController.text);
        pics.add(pic);
        print("Tirou foto");
      }
    }
  }

  vizualizePic() {}
  deletePic() {}
  renamePic() {}
  addPic(Pic pic) {}
}
