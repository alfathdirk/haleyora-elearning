class EmployeeData {
  final String? id;
  final String? employeeId;
  final String? fullName;
  final String? email;
  final String? username;
  final String? role;
  final String? image;
  final String? status;
  final String? workStatus;
  final String? photo;
  final String? placement;
  final String? gender;
  final String? placeOfBirth;
  final String? dateOfBirth;
  final String? address;
  final String? phone;
  final String? religion;
  final String? unitPLN;
  final String? position;
  final String? unit;
  final String? job;

  EmployeeData({
    this.id,
    this.employeeId,
    this.fullName,
    this.email,
    this.username,
    this.role,
    this.image,
    this.status,
    this.workStatus,
    this.photo,
    this.placement,
    this.gender,
    this.placeOfBirth,
    this.dateOfBirth,
    this.address,
    this.phone,
    this.religion,
    this.unitPLN,
    this.position,
    this.unit,
    this.job,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    print(json);
    return EmployeeData(
      id: json['id'],
      employeeId: json['employee_id'],
      fullName: json['full_name'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      image: json['image'],
      status: json['status'],
      workStatus: json['work_status'],
      photo: json['photo'],
      placement: json['placement'],
      gender: json['gender'],
      placeOfBirth: json['place_of_birth'],
      dateOfBirth: json['date_of_birth'],
      address: json['address'],
      phone: json['phone'],
      religion: json['religion'],
      unitPLN: json['unit_pln'],
      position: json['position'],
      unit: json['unit'],
      job: json['job'],
    );
  }
}

class CourseMe {
  final String? id;
  final String? status;
  final String? title;
  final String? image;
  final int? duration;
  final String? activities;

  CourseMe({
    this.id,
    this.status,
    this.title,
    this.image,
    this.duration,
    this.activities,
  });

  factory CourseMe.fromJson(Map<String, dynamic> json) {
    return CourseMe(
      id: json['id'],
      status: json['status'],
      title: json['title'],
      image: json['image'],
      duration: json['duration'],
      activities: json['activities'],
    );
  }
}

class OngoingCourseData {
  final String? id;
  final int? examScore;
  final int? lastVideoDuration;
  final int? videoDuration;
  final CourseMe? course;
  final List<dynamic>? tasks;

  OngoingCourseData({
    this.id,
    this.examScore,
    this.lastVideoDuration,
    this.course,
    this.tasks,
    this.videoDuration,
  });

  factory OngoingCourseData.fromJson(Map<String, dynamic> json) {
    return OngoingCourseData(
      id: json['id'],
      examScore: json['exam_score'],
      lastVideoDuration: json['last_video_duration'],
      videoDuration: json['video_duration'],
      course: CourseMe.fromJson(json['course']),
      tasks: json['tasks'] ?? [],
    );
  }
}

class ResponseData {
  final EmployeeData? employeeData;
  final List<dynamic>? ongoingCourses;
  final List<dynamic>? completedCourses;
  final List<dynamic>? recommendationCourses;
  final String? ongoingQuizDataMessage;
  final List<dynamic>? searchHistoryData;
  final Map<String, List<dynamic>>? notificationData;

  ResponseData({
    this.employeeData,
    this.ongoingCourses,
    this.completedCourses,
    this.recommendationCourses,
    this.ongoingQuizDataMessage,
    this.searchHistoryData,
    this.notificationData,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      employeeData: EmployeeData.fromJson(json['employeeData']),
      ongoingCourses: json['employeeCourseData']['ongoing']
          .map((courseJson) => OngoingCourseData.fromJson(courseJson))
          .toList(),
      completedCourses: json['employeeCourseData']['completed']
          .map((courseJson) => OngoingCourseData.fromJson(courseJson))
          .toList(),
      recommendationCourses: json['employeeCourseData']['recommendation'] ?? [],
      ongoingQuizDataMessage: json['ongoingQuizData']['message'],
      searchHistoryData: json['searchHistoryData'] ?? [],
      notificationData: {
        'unread': json['notificationData']['unread'] ?? [],
        'read': json['notificationData']['read'] ?? [],
      },
    );
  }
}
