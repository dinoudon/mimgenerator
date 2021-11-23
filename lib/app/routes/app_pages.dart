import 'package:get/get.dart';

import 'package:memegen/app/modules/edit_meme/bindings/edit_meme_binding.dart';
import 'package:memegen/app/modules/edit_meme/views/edit_meme_view.dart';
import 'package:memegen/app/modules/home/bindings/home_binding.dart';
import 'package:memegen/app/modules/home/views/home_view.dart';
import 'package:memegen/app/modules/list_meme/bindings/list_meme_binding.dart';
import 'package:memegen/app/modules/list_meme/views/list_meme_view.dart';
import 'package:memegen/app/modules/result_meme/bindings/result_meme_binding.dart';
import 'package:memegen/app/modules/result_meme/views/result_meme_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LIST_MEME,
      page: () => ListMemeView(),
      binding: ListMemeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_MEME,
      page: () => EditMemeView(),
      binding: EditMemeBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_MEME,
      page: () => ResultMemeView(),
      binding: ResultMemeBinding(),
    ),
  ];
}
