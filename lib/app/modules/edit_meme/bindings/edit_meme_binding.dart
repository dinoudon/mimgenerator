import 'package:get/get.dart';

import '../controllers/edit_meme_controller.dart';

class EditMemeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMemeController>(
      () => EditMemeController(),
    );
  }
}
