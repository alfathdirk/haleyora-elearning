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

class CourseResponseByEmployee {
  CourseData? course;

  CourseResponseByEmployee({this.course});

  CourseResponseByEmployee.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? CourseData.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (course != null) {
      data['course'] = course!.toJson();
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

class CategoryResponse {
  List<CategoryData>? data;

  CategoryResponse({this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class BookmarkResponse {
  List<CourseBookmarkByEmployee>? data;

  BookmarkResponse({this.data});

  BookmarkResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CourseBookmarkByEmployee>[];
      json['data'].forEach((v) {
        data!.add(CourseBookmarkByEmployee.fromJson(v));
      });
    }
  }
}
