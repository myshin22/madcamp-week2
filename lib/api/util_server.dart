import 'dart:io';

import 'package:dio/dio.dart';

const baseUrl = "https://madcamp-week-2-server-production.up.railway.app";

Future<dynamic> fetchPost(url, data) async {
  final response = await Dio().post("$baseUrl/$url", data: data);
  print("fetchPost");
  print(response.statusCode);
  print(response.data);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return response.data;
  } else {
    throw Exception("fetch post");
  }
}

Future<String> uploadImage(File file) async {
  String fileName = file.path.split('/').last;
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(file.path, filename: fileName),
  });
  final body = await fetchPost("test/public-upload", formData);
  return body["key"];
}
