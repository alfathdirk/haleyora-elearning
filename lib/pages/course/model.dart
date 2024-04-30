import '../../model/model.dart';

class CourseResponse {
  List<CourseData>? data;

  CourseResponse({this.data});

  CourseResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseData>[];
      json['data'].forEach((v) {
        data!.add(CourseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseDetailResponse {
  CourseData? data;

  CourseDetailResponse({this.data});

  CourseDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CourseData.fromJson(json['data']) : null;
  }
}
