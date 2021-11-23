import 'package:json_annotation/json_annotation.dart';

part 'get_memes.g.dart';

@JsonSerializable()
class Get_memes {
  Get_memes();

  late bool success;
  late Map<String, dynamic> data;

  factory Get_memes.fromJson(Map<String, dynamic> json) =>
      _$Get_memesFromJson(json);
  Map<String, dynamic> toJson() => _$Get_memesToJson(this);
}
