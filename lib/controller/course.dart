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
  }

  Future<void> bookmarkCourse(String courseId, String empId) async {
    try {
      final result = await dio.post('/items/employee_course', data: {
        'employee': empId,
        'course': courseId,
      });
      await getCourseByEmployeeId(empId);
      print('bookmark success');
    } catch (e) {
      print('error bookmarkCourse: $e');
    }
  }

  Future<void> fetchAllCourses() async {
    try {
      loading.value = true;
      isAllCourse.value = true;
      final result = await dio.get(
          '/items/course?fields[]=*,image.*,activities.title,activities.id,employee_course.*');
      // print(json.encode(result.data));
      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      courseList.value = courseResponse.data!.toList();
      // courseList.value = courseResponse.data!.toList();
      // loading.value = false;
      print('by all');
    } catch (e) {
      print('error fetchAllCourses: $e');
    }
  }

  Future<void> fetchCourseById(String id) async {
    loading.value = true;
    final result = await dio.get(
        '/items/course/$id?fields[]=*,image.*,activities.title,activities.id');
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
