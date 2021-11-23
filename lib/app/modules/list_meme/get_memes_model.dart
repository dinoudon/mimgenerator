import 'dart:convert';

class GetMemes {
  bool? success;
  MemeData? data;

  GetMemes({this.success, this.data});

  GetMemes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? MemeData?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (data != null) {
      data['data'] = jsonEncode(data);
    }
    return data;
  }
}

class MemeData {
  List<Memes>? memes;

  MemeData({this.memes});

  MemeData.fromJson(Map<String, dynamic> json) {
    if (json['memes'] != null) {
      memes = <Memes>[];
      json['memes'].forEach((v) {
        memes!.add(Memes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (memes != null) {
      data['memes'] = memes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Memes {
  String? id;
  String? name;
  String? url;
  int? width;
  int? height;
  int? boxCount;

  Memes({this.id, this.name, this.url, this.width, this.height, this.boxCount});

  Memes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['box_count'] = boxCount;
    return data;
  }
}
