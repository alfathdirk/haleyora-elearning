import 'package:get/get.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/pages/course/model.dart';
import 'package:haleyora/services/dio_client.dart';

class CourseController extends GetxController {
  final courseList = [].obs;
  final courseDetail = CourseData().obs;
  final loading = false.obs;

  @override
  void onInit() {
    fetchAllCourses();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchAllCourses() async {
    loading.value = true;
    final result = await dio
        .get('/items/course?fields[]=*,image.*,activities.title,activities.id');
    CourseResponse courseResponse = CourseResponse.fromJson(result.data);
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
}
