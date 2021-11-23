import 'package:get/get.dart';
import 'package:memegen/app/modules/list_meme/get_memes_model.dart';

class GetMemeProvider extends GetConnect {
  Future<Response> getMemes() => get('https://api.imgflip.com/get_memes');

  @override
  void onInit() {}
}
