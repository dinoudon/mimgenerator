import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memegen/app/modules/result_meme/bindings/result_meme_binding.dart';
import 'package:memegen/app/modules/result_meme/views/result_meme_view.dart';
import 'package:screenshot/screenshot.dart';

import '../controllers/edit_meme_controller.dart';
import 'package:text_editor/text_editor.dart';

class EditMemeView extends GetView<EditMemeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ElevatedButton(
                  child: Text("Add Logo"),
                  onPressed: () async {
                    if (controller.position_reveal_logo.value < 3) {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery, maxHeight: 200);
                      if (image != null) {
                        controller.listLogo[controller
                            .position_reveal_logo.value] = image!.path;
                        controller.visibilityLogo[
                            controller.position_reveal_logo.value] = true;
                        controller.position_reveal_logo.value += 1;
                      }
                    } else {
                      Get.showSnackbar(
                        GetBar(
                          title: "Warning",
                          message: "Maximum Logo Reached.",
                          snackPosition: SnackPosition.TOP,
                          duration: Duration(milliseconds: 1500),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: Text("Add Text"),
              onPressed: () {
                if (controller.position_reveal.value < 3) {
                  controller.visibility[controller.position_reveal.value] =
                      true;
                  controller.visibility.refresh();
                  controller.position_reveal.value += 1;
                } else {
                  Get.showSnackbar(
                    GetBar(
                      title: "Warning",
                      message: "Maximum Text Reached.",
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(milliseconds: 1500),
                    ),
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              child: Text("Finish"),
              onPressed: () async {
                controller.screenshotController
                    .capture()
                    .then((Uint8List? image) {
                  //Capture Done
                  // Uint8List? _imageFile;
                  // _imageFile = image;
                  print(image!.length);
                  Get.to(() => ResultMemeView(),
                      binding: ResultMemeBinding(), arguments: [image]);
                }).catchError((onError) {
                  print(onError);
                });
                // RenderRepaintBoundary boundary =
                //     _globalKey.currentContext.findRenderObject();
                // Image image = await boundary.toImage();
              },
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('EditMemeView'),
        centerTitle: true,
      ),
      body: Screenshot(
        controller: controller.screenshotController,
        child: Obx(
          () => Stack(
            fit: StackFit.loose,
            // children: controller.listWidget,
            children: [
              Center(
                child: Image.network(
                  Get.arguments[0],
                  fit: BoxFit.cover,
                ),
              ),
              // ...controller.listWidget,

              addTextManual(context, 0),
              addTextManual(context, 1),
              addTextManual(context, 2),
              addLogoManual(context, 0),
              addLogoManual(context, 1),
              addLogoManual(context, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTextManual(context, pos) {
    // int pos = controller.listWidget.length;
    print(pos);
    controller.listPosX.add(10.0);
    controller.listPosY.add(10.0);
    controller.listTextAlign.add(TextAlign.center);
    controller.visibility.add(false);
    controller.listText.add('Your Text $pos');
    controller.listTextStyle.add(
      TextStyle(
        fontSize: 50,
        color: Colors.black,
        fontFamily: 'Billabong',
      ),
    );
    return Visibility(
      visible: controller.visibility[pos],
      child: Positioned(
        left: controller.listPosX[pos],
        top: controller.listPosY[pos],
        child: Draggable(
          onDragUpdate: (details) {
            print(details);
            controller.listPosX[pos] =
                controller.listPosX[pos] + details.delta.dx;
            controller.listPosX.refresh();
            controller.listPosY[pos] =
                controller.listPosY[pos] + details.delta.dy;
            print(pos.toString() +
                " : " +
                controller.listPosX.value[pos].toString());
            controller.listPosY.refresh();
            controller.listWidget.refresh();
          },
          feedback: Container(),
          child: GestureDetector(
            onTap: () => _tapHandler(context, pos),
            child: Container(
              width: 300,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: AutoSizeText(
                    controller.listText[pos],
                    textAlign: controller.listTextAlign[pos],
                    style: controller.listTextStyle[pos],
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addLogoManual(context, pos) {
    // int pos = controller.listWidget.length;
    print(pos);
    controller.listPosXLogo.add(10.0);
    controller.listPosYLogo.add(10.0);
    controller.visibilityLogo.add(true);
    controller.listLogo.add("");
    return Visibility(
      visible: controller.visibilityLogo[pos],
      child: Positioned(
        left: controller.listPosXLogo[pos],
        top: controller.listPosYLogo[pos],
        child: Draggable(
          onDragUpdate: (details) {
            print(details);
            controller.listPosXLogo[pos] =
                controller.listPosXLogo[pos] + details.delta.dx;
            controller.listPosXLogo.refresh();
            controller.listPosYLogo[pos] =
                controller.listPosYLogo[pos] + details.delta.dy;
            print(pos.toString() +
                " : " +
                controller.listPosXLogo.value[pos].toString());
            controller.listPosYLogo.refresh();
          },
          feedback: Container(),
          child: InteractiveViewer(
            child: controller.listLogo[pos] == ""
                ? Container()
                : Image.file(
                    File(controller.listLogo[pos]),
                  ),
          ),
        ),
      ),
    );
  }

  void addText(context) {
    int pos = controller.listWidget.length;
    print(pos);
    controller.listPosX.add(10.0);
    controller.listPosY.add(10.0);
    controller.listText.add('Your Text $pos');
    controller.listTextStyle.add(
      TextStyle(
        fontSize: 50,
        color: Colors.black,
        fontFamily: 'Billabong',
      ),
    );

    Widget child = Positioned(
      left: controller.listPosX[pos],
      top: controller.listPosY[pos],
      child: Draggable(
        onDragUpdate: (details) {
          print(details);
          controller.listPosX[pos] =
              controller.listPosX[pos] + details.delta.dx;
          controller.listPosX.refresh();
          controller.listPosY[pos] =
              controller.listPosY[pos] + details.delta.dy;
          print(pos.toString() +
              " : " +
              controller.listPosX.value[pos].toString());
          controller.listPosY.refresh();
          controller.listWidget.refresh();
        },
        feedback: Container(),
        child: GestureDetector(
          onTap: () => _tapHandler(context, pos),
          child: Container(
            width: 300,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: AutoSizeText(
                  controller.listText[pos],
                  textAlign: TextAlign.center,
                  style: controller.listTextStyle[pos],
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    controller.listWidget.add(child);
    controller.listWidget.refresh();
  }

  void _tapHandler(context, pos) {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return Container(
            color: Colors.black.withOpacity(0.4),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                // top: false,
                child: Container(
                  child: TextEditor(
                    fonts: controller.fonts,
                    text: controller.listText[pos],
                    textStyle: controller.listTextStyle[pos],
                    textAlingment: controller.listTextAlign[pos],
                    minFontSize: 10,
                    onEditCompleted: (style, align, text) {
                      controller.listTextStyle[pos] = style;
                      // controller.lis.value = align;
                      controller.listText[pos] = text;
                      controller.listText.refresh();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}

abstract class Topping {
  void changeContent();
  void delete();
}

class TextOverImage extends Topping {
  @override
  void changeContent() {
    // TODO: implement changeContent
  }

  @override
  void delete() {
    // TODO: implement delete
  }
}

class ImageOverImage extends Topping {
  @override
  void changeContent() {
    // TODO: implement changeContent
  }

  @override
  void delete() {
    // TODO: implement delete
  }
}
