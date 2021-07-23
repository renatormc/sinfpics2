import 'dart:io';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sinfpics2/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  showModalBottomSheet() {
    Get.bottomSheet(
      Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
                leading: new Icon(Icons.zoom_in),
                title: new Text('Vizualizar'),
                onTap: () {
                  Get.back();
                  controller.vizualizePic();
                }),
            ListTile(
              leading: new Icon(Icons.delete_forever),
              title: new Text('Deletar'),
              onTap: () {
                Get.back();
                controller.deletePic();
              },
            ),
            ListTile(
                leading: new Icon(Icons.edit),
                title: new Text('Renomear'),
                onTap: () {
                  Get.back();
                  controller.renamePic();
                }),
          ],
        ),
      ),
      barrierColor: Colors.red[50],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(width: 5, color: Colors.black)),
      enableDrag: false,
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: !controller.modalOpened.value
          ? AppBar(title: Text("Sinfpics"), actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Deletar todas',
                onPressed: controller.clearFolder,
              ),
              IconButton(
                icon: const Icon(Icons.update),
                tooltip: 'Recarregar fotos',
                onPressed: controller.loadPictures,
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Tirar foto',
                onPressed: controller.getImage,
              ),
            ])
          : null,
      body: !controller.modalOpened.value
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    left: 5,
                    right: 5,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do objeto',
                    ),
                    controller: controller.objNameController,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.pics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: InkWell(
                            onTap: () {
                              controller.selectedPicIndex.value = index;
                              controller.vizualizePic();
                            },
                            onLongPress: () {
                              controller.selectedPicIndex.value = index;
                              showModalBottomSheet();
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: FutureBuilder(
                                    future: controller.pics[index].thumb,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Image.file(
                                            snapshot.data as File);
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Text(controller.pics[index].name),
                              ],
                            ),
                          ));
                    },
                  ),
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                    child: controller.selectedPicIndex > -1
                        ? PhotoView(
                            imageProvider: FileImage(controller
                                .pics[controller.selectedPicIndex.value].file),
                          )
                        : Text("Nenhuma imagem selecionada")),
                MaterialButton(
                  height: 40.0,
                  minWidth: double.infinity,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text("Fechar foto"),
                  onPressed: () {
                    controller.modalOpened.value = false;
                  },
                  splashColor: Colors.redAccent,
                )
              ],
            ),
    );
  }
}
