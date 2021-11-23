import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/result_meme_controller.dart';

class ResultMemeView extends GetView<ResultMemeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MimGenerator'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: Get.height * 0.7, child: Image.memory(Get.arguments[0])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Uint8List image = Get.arguments[0];
                    final dir = await getExternalStorageDirectory();
                    final myImagePath = dir!.path +
                        "/${DateTime.now().microsecondsSinceEpoch.toString()}.png";
                    File imageFile = File(myImagePath);
                    print(myImagePath);
                    if (!await imageFile.exists()) {
                      imageFile.create(recursive: true);
                    }
                    imageFile.writeAsBytes(image);
                    Get.showSnackbar(
                      GetBar(
                        isDismissible: true,
                        title: "Saved.",
                        message: "File Saved in ${imageFile.path}",
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(milliseconds: 2000),
                      ),
                    );
                  },
                  child: Text("Simpan")),
              ElevatedButton(
                  onPressed: () => _shareImage(), child: Text("Share")),
            ],
          )
        ],
      ),
    );
  }

  _shareImage() async {
    try {
      Uint8List image = Get.arguments[0];

      final tempDir = await getTemporaryDirectory();
      final file = await new File(
              '${tempDir.path}/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg')
          .create();
      file.writeAsBytesSync(image);

      Share.shareFiles([file.path], text: 'Great Meme!');
    } catch (e) {
      print('Share error: $e');
    }
  }
}
