import 'dart:developer';

import 'package:get/get.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/pages/course/model.dart';
import 'package:haleyora/services/dio_client.dart';

class CourseController extends GetxController {
  final courseList = [].obs;
  final searchResults = [].obs;
  final courseDetail = CourseData().obs;
  final isAllCourse = true.obs;
  final loading = false.obs;
  final categoryList = [].obs;
  final tabOngoing = false.obs;
  final courseByEmployee = ResponseCourseByEmployee().obs;
  final listFilter = [].obs;
  final courseRecommendation = [].obs;
  final loadingTakeCourse = false.obs;

  final myCourseList = [].obs;

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

  Future<void> takeCourse(String courseId, String empId) async {
    try {
      loadingTakeCourse.value = true;
      final result = await dio.post('/items/employee_course', data: {
        'employee': empId,
        'course': courseId,
      });
      await getCourseByEmployee(empId, courseId);
      loadingTakeCourse.value = false;
      return result.data;
    } catch (e) {
      print('error bookmarkCourse: $e');
      loadingTakeCourse.value = false;
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
      isAllCourse.value = true;
      final result = await dio.get(
          '/items/course?limit=200&fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id');
      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      courseList.value = courseResponse.data!.toList();
    } catch (e) {
      print('error fetchAllCourses: $e');
    }
  }

  Future<void> fetchCourseById(String id) async {
    try {
      loading.value = true;
      final result = await dio.get(
          '/items/course/$id?limit=200&fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id');
      loading.value = false;
      courseDetail.value = CourseDetailResponse.fromJson(result.data).data!;
      return result.data;
    } catch (e) {
      print('error fetchCourseById: $e');
    }
  }

  Future<void> getCategory() async {
    try {
      final result = await dio.get('/items/category');
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(result.data);
      categoryList.value = categoryResponse.data!.toList();
    } catch (e) {
      log('error getCategory: $e');
      print('error getCategory: $e');
    }
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

  Future<void> searchCourse(String query) async {
    String listQuery = '';
    String q = '';
    if (listFilter.isNotEmpty) {
      int i = 0;
      listFilter.forEach((element) {
        if (i != 0) {
          q += ',';
        }
        q +=
            '{"activities": {"sub_sector" : {"sector_id": {"category_id": {"_eq": "$element"}}}}}';
        i++;
      });
    }
    listQuery =
        '&filter={"_or": [$q], "_and": [{"title": {"_contains": "$query"}}]}';
    try {
      final result = await dio.get(
          '/items/course?fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id$listQuery');

      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      searchResults.value = courseResponse.data!.toList();
    } catch (e) {
      print('error searchCourse: $e');
    }
  }

  Future<void> searchCourseByActivity(String activityId) async {
    try {
      final result = await dio.get(
          '/items/course?fields[]=*,image.*,activities.title,activities.id,employee_course.*, employee_bookmark.id, employee_bookmark.employee_id&filter[activities][_eq]=$activityId');
      CourseResponse courseResponse = CourseResponse.fromJson(result.data);
      searchResults.value = courseResponse.data!.toList();
    } catch (e) {
      print('error searchCourseByActivity: $e');
    }
  }

  Future<void> getCourseByEmployee(String empId, String? courseId) async {
    String withCourse = '';
    try {
      if (courseId != null) {
        withCourse = '&filter[course][_eq]=$courseId';
      }
      final result = await dio.get(
          '/items/employee_course?fields[]=id, course.id, course.title, course.min_score, course.exam_quiz, course.activities.id,course.activities.title, completed, exam_score, tasks_score, last_video_duration, exam_attempt,tasks.id, tasks.directus_files_id.*&filter[employee][_eq]=$empId$withCourse');
      ResponseCourseByEmployee resultEmployee =
          ResponseCourseByEmployee.fromJson(result.data);
      courseByEmployee.value = resultEmployee;
    } catch (e) {
      print('error getTaskByEmployeeId: $e');
    }
  }

  Future<void> getCourseRecommendation(String empId) async {
    try {
      final result = await dio.get(
          '/items/employee_course_recommendation?fields[]=course.*.*&filter[employee][_eq]=$empId');
      CourseRecommendationResponse courseResponse =
          CourseRecommendationResponse.fromJson(result.data);
      courseRecommendation.value = courseResponse.data!.toList();
    } catch (e) {
      print('error getCourseRecommendation: $e');
    }
  }

  Future<void> setTabOngoing(bool value) async {
    tabOngoing.value = value;
  }

  void setMyCourseList(List<dynamic> courseList, bool tabOnGoing) {
    myCourseList.value = courseList;
    setTabOngoing(tabOnGoing);
  }
}
