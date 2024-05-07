import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

checkTypeFile(String type) {
  if (type == 'pdf') {
    return MediaType('application', 'pdf');
  } else if (type == 'jpg' || type == 'jpeg') {
    return MediaType('image', 'jpeg');
  } else if (type == 'png') {
    return MediaType('image', 'png');
  } else if (type == 'mp4') {
    return MediaType('video', 'mp4');
  } else {
    return MediaType('application', 'octet-stream');
  }
}

Future<FormData> uploadImage(File imageFile) async {
  try {
    String fileName = imageFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path,
          filename: fileName,
          contentType: checkTypeFile(fileName.split('.').last))
    });
    return formData;
  } catch (e) {
    throw Exception('Failed to upload image: $e');
  }
}
