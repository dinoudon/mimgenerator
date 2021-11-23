import 'package:get/get.dart';

import '../controllers/result_meme_controller.dart';

class ResultMemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultMemeController>(
      () => ResultMemeController(),
    );
  }
}
