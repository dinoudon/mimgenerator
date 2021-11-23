import 'package:get/get.dart';
import 'package:memegen/app/data/get_meme_provider.dart';
import 'package:memegen/app/modules/list_meme/get_memes_model.dart';

class ListMemeController extends GetxController {
  //TODO: Implement ListMemeController
  GetMemeProvider memeProvider = GetMemeProvider();
  RxList<Memes> memeResponse = RxList.empty();
  // MemeData memeData = memeProvider.getMemes();
  var isDone = false.obs;
  final count = 0.obs;

  getMemes() {
    memeProvider.getMemes().then((value) {
      isDone.value = false;
      GetMemes memes = GetMemes.fromJson(value.body);
      memeResponse = memes.data!.memes!.obs;
      memeResponse.refresh;
      isDone.value = true;
      print(memeResponse[0].url);
    });
  }

  @override
  void onInit() {
    getMemes();
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
