import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class EditMemeController extends GetxController {
  //TODO: Implement EditMemeController

  var fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];
  Rx<TextStyle> textStyle = TextStyle(
    fontSize: 50,
    color: Colors.black,
    fontFamily: 'Billabong',
  ).obs;
  var text = 'Sample Text'.obs;
  Rx<TextAlign> textAlign = TextAlign.center.obs;

  RxList<double> positionX = [0.0, 0.0].obs;
  RxList<double> positionY = [0.0, 0.0].obs;

  var position_reveal = 0.obs;
  var position_reveal_logo = 0.obs;

  RxList<bool> visibility = RxList.empty();
  RxList<TextAlign> listTextAlign = RxList.empty();

  RxList<double> listPosX = RxList.empty();
  RxList<double> listPosY = RxList.empty();

  RxList<TextStyle> listTextStyle = RxList.empty();
  RxList<String> listText = RxList.empty();
  RxList<Widget> listWidget = RxList.empty();

  RxList<bool> visibilityLogo = RxList.empty();

  RxList<double> listPosXLogo = RxList.empty();
  RxList<double> listPosYLogo = RxList.empty();

  RxList<String> listLogo = RxList.empty();

  RxDouble dx = 0.0.obs;
  RxDouble dy = 0.0.obs;
  Offset offset = Offset.zero;

  ScreenshotController screenshotController = ScreenshotController();

  final count = 0.obs;
  @override
  void onInit() {
    offset = Offset(dx.value, dy.value);

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
