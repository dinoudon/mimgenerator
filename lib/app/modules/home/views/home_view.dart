import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:memegen/app/modules/list_meme/bindings/list_meme_binding.dart';
import 'package:memegen/app/modules/list_meme/views/list_meme_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text('MemeGen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () =>
                    Get.to(() => ListMemeView(), binding: ListMemeBinding()),
                child: Text("Create new Meme"))
          ],
        ),
      ),
    );
  }
}
