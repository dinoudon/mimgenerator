import 'package:get/get.dart';

import '../controllers/list_meme_controller.dart';

class ListMemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMemeController>(
      () => ListMemeController(),
    );
  }
}
