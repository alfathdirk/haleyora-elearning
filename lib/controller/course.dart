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

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getCourseByEmployeeId(String empId) async {
    loading.value = true;
    isAllCourse.value = false;
    final result = await dio.get(
        '/items/course?fields[]=*,image.*,activities.title,activities.id&filter[employee_course][employee][_eq]=4d738816-62bc-43db-bdf2-de28782f1872');
    CourseResponse courseResponse = CourseResponse.fromJson(result.data);
    print('by id');
    courseList.value = courseResponse.data!.toList();
    loading.value = false;
  }

  Future<void> fetchAllCourses() async {
    loading.value = true;
    isAllCourse.value = true;
    final result = await dio
        .get('/items/course?fields[]=*,image.*,activities.title,activities.id');
    CourseResponse courseResponse = CourseResponse.fromJson(result.data);
    print('by all');
    courseList.value = courseResponse.data!.toList();
    loading.value = false;
  }

  Future<void> fetchCourseById(String id) async {
    loading.value = true;
    final result = await dio.get(
        '/items/course/${id}?fields[]=*,image.*,activities.title,activities.id');
    loading.value = false;
    courseDetail.value = CourseDetailResponse.fromJson(result.data).data!;
    return result.data;
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
}
