import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/services/dio_client.dart';

class CertificateController extends GetxController {
  var isLoading = true.obs;
  var certificateDetail = CertificateData(
    id: 0,
    dateCreated: '',
    dateUpdated: '',
    expiredDays: 0,
    employeeName: '',
    courseTitle: '',
  ).obs;

  final box = GetStorage();
  // Sector
  Future<CertificateData> getCertificateByCourseId(String courseId) async {
    var empId = box.read('employee_id');
    log('/items/employee_certificate?filter[employee][_eq]=$empId&filter[course][_eq]=$courseId&fields[]=*, employee.full_name, course.course.title');
    try {
      isLoading(true);
      final result = await dio.get(
          '/items/employee_certificate?filter[employee][_eq]=$empId&filter[course][_eq]=$courseId&fields[]=*, employee.full_name, course.course.title');
      if (result.data['data'].isNotEmpty) {
        return CertificateData.fromJson(result.data['data'][0]);
      }
      return CertificateData(
        id: 0,
        dateCreated: '',
        dateUpdated: '',
        expiredDays: 0,
        employeeName: '',
        courseTitle: '',
      );
    } catch (e) {
      log('error getCertificateByCourseId: $e');
    } finally {
      isLoading(false);
    }
    return CertificateData(
      id: 0,
      dateCreated: '',
      dateUpdated: '',
      expiredDays: 0,
      employeeName: '',
      courseTitle: '',
    );
  }

  Future<CertificateSetting> getCertificateSetting() async {
    try {
      final result = await dio.get('/items/certificate_setting');
      if (result.data['data'].isNotEmpty) {
        return CertificateSetting.fromJson(result.data['data'][0]);
      }
      return CertificateSetting(
        title: '',
        signature: '',
        pic: '',
      );
    } catch (e) {
      log('error getCertificateSetting: $e');
    }
    // Return a default CertificateSetting if no data is found or an error occurs
    return CertificateSetting(
      title: '',
      signature: '',
      pic: '',
    );
  }
}

class CertificateSetting {
  final String title;
  final String signature;
  final String pic;

  CertificateSetting({
    required this.title,
    required this.signature,
    required this.pic,
  });

  factory CertificateSetting.fromJson(Map<String, dynamic> json) {
    return CertificateSetting(
      title: json['title'] ?? '',
      signature: json['signature'] ?? '',
      pic: json['pic'] ?? '',
    );
  }
}

class CertificateResponse {
  final List<CertificateData> data;

  CertificateResponse({required this.data});

  factory CertificateResponse.fromJson(List<dynamic> json) {
    return CertificateResponse(
      data: json.map((e) => CertificateData.fromJson(e)).toList(),
    );
  }
}

class CertificateData {
  final int id;
  final String dateCreated;
  final String dateUpdated;
  final int expiredDays;
  final String employeeName;
  final String courseTitle;

  CertificateData({
    required this.id,
    required this.dateCreated,
    required this.dateUpdated,
    required this.expiredDays,
    required this.employeeName,
    required this.courseTitle,
  });

  factory CertificateData.fromJson(Map<String, dynamic> json) {
    return CertificateData(
      id: json['id'],
      dateCreated: json['date_created'],
      dateUpdated: json['date_updated'] ?? DateTime.now().toString(),
      expiredDays: json['expired_days'],
      employeeName: json['employee']['full_name'],
      courseTitle: json['course']['course']['title'],
    );
  }
}
