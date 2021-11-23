import 'package:get/get.dart';

import '../get_memes_model.dart';

class GetMemesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return GetMemes.fromJson(map);
      if (map is List)
        return map.map((item) => GetMemes.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<GetMemes?> getGetMemes(int id) async {
    final response = await get('getmemes/$id');
    return response.body;
  }

  Future<Response<GetMemes>> postGetMemes(GetMemes getmemes) async =>
      await post('getmemes', getmemes);
  Future<Response> deleteGetMemes(int id) async => await delete('getmemes/$id');
}
