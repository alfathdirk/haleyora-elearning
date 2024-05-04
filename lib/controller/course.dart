import 'dart:convert';

import 'package:get/get.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/pages/course/model.dart';
import 'package:haleyora/services/dio_client.dart';

class CourseController extends GetxController {
  final courseList = [].obs;
  final courseDetail = CourseData().obs;
  final isAllCourse = true.obs;
  final loading = false.obs;
  final categoryList = [].obs;

  @override
  void onInit() {
    fetchAllCourses();
    getCategory();
    super.onInit();
  }

  Future<void> getCourseByEmployeeId(String empId) async {
    try {
      loading.value = true;
      isAllCourse.value = false;
      final result = await dio.get(
          '/items/course?fields[]=*,image.*,activities.title,activities.id,employee_course.*&filter[employee_course][employee][_eq]=$empId');
      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      print('by id');
      courseList.value = courseResponse.data!.toList();
      loading.value = false;
    } catch (e) {
      print('error getCourseByEmployeeId: $e');
    }

    // await courseController.getCourseByEmployeeId(
    //     authController.currentUser.value.employeeData!.id
    //         .toString());
  }

  Future<void> takeCourse(String courseId, String empId) async {
    try {
      final result = await dio.post('/items/employee_course', data: {
        'employee': empId,
        'course': courseId,
      });
      print('bookmark success');
    } catch (e) {
      print('error bookmarkCourse: $e');
    }
  }

  Future<void> getBookmarkByEmployee(String empId) async {
    try {
      isAllCourse.value = false;
      final result = await dio.get(
          '/items/employee_bookmark?filter[employee_id][_eq]=$empId&fields[]=*');
      BookmarkResponse courseBookmarkByEmployee =
          BookmarkResponse.fromJson(result.data);
      List<CourseBookmarkByEmployee> listBookmark =
          courseBookmarkByEmployee.data!.toList();
      final listCourseBookmark = [];
      for (var element in listBookmark) {
        final result = await dio.get(
            '/items/course/${element.course}?fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id');
        listCourseBookmark.add(result.data['data']);
      }
      CourseResponse courseResponse = CourseResponse.fromJson({
        'data': listCourseBookmark,
      });
      courseList.value = courseResponse.data!.toList();
    } catch (e) {
      print('error unBookmarkCourse: $e');
    }
  }

  Future<void> fetchAllCourses() async {
    try {
      loading.value = true;
      isAllCourse.value = true;
      final result = await dio.get(
          '/items/course?fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id');

      // object add DONT DELETE
      // List<CourseData> updatedData =
      //     List<CourseData>.from(result.data['data'].map((x) {
      //   final courseIds = x['employee_course']
      //       ?.map((element) => element['employee'])
      //       .toList();
      //   bool isBookmarked = courseIds!.contains(1);
      //   x['isBookmarked'] = isBookmarked;
      //   return CourseData.fromJson(x);
      // }));

      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      courseList.value = courseResponse.data!.toList();
      loading.value = false;
      print('by all');
    } catch (e) {
      print('error fetchAllCourses: $e');
    }
  }

  Future<void> fetchCourseById(String id) async {
    try {
      loading.value = true;
      final result = await dio.get(
          '/items/course/$id?fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id');
      loading.value = false;
      courseDetail.value = CourseDetailResponse.fromJson(result.data).data!;
      return result.data;
    } catch (e) {
      print('error fetchCourseById: $e');
    }
  }

  Future<void> getCategory() async {
    final result = await dio.get('/items/category');
    CategoryResponse categoryResponse = CategoryResponse.fromJson(result.data);
    categoryList.value = categoryResponse.data!.toList();
    // categoryList.value = courseResponse.data!.toList();
    // courseList.value = courseResponse
    // final List<dynamic> modelsJson = parsedJson['data'];
    // categoryList.value = data;
  }

  Future<void> bookmarkCourse(String courseId, String empId) async {
    try {
      await dio.post('/items/employee_bookmark', data: {
        'employee_id': empId,
        'course': courseId,
      });
      print('bookmark success');
    } catch (e) {
      print('error bookmarkCourse: $e');
    }
  }

  Future<void> unBookmarkCourse(String courseId, String empId) async {
    try {
      await dio.delete('/items/employee_bookmark', data: {
        'query': {
          'filter': {
            'employee_id': {'_eq': empId},
            'course': {'_eq': courseId}
          }
        }
      });
      print('unbookmark success');
    } catch (e) {
      print('error unBookmarkCourse: $e');
    }
  }
}
