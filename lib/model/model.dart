
class CourseData {
  String? id;
  String? status;
  String? userCreated;
  String? dateCreated;
  String? userUpdated;
  String? dateUpdated;
  String? title;
  ActivitiesData? activities;
  int? duration;
  dynamic materialContent;
  dynamic videoContent;
  bool? isOpenExam;
  bool? isOpenTask;
  int? minScore;
  dynamic examQuiz;
  List<EmployeeCourseData>? employeeCourse;
  List<CourseBookmarkByEmployee>? employeeBookmark;
  ImageData? image;
  String? description;
  String? taskDescription;

  CourseData({
    this.id,
    this.status,
    this.userCreated,
    this.dateCreated,
    this.userUpdated,
    this.dateUpdated,
    this.title,
    this.activities,
    this.duration,
    this.materialContent,
    this.videoContent,
    this.isOpenExam,
    this.isOpenTask,
    this.minScore,
    this.examQuiz,
    this.employeeCourse,
    this.employeeBookmark,
    this.image,
    this.description,
    this.taskDescription,
  });

  CourseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userCreated = json['user_created'];
    dateCreated = json['date_created'];
    userUpdated = json['user_updated'];
    dateUpdated = json['date_updated'];
    title = json['title'];
    activities = json['activities'] != null
        ? ActivitiesData.fromJson(json['activities'])
        : null;
    duration = json['duration'];
    materialContent = json['material_content'];
    videoContent = json['video_content'];
    isOpenExam = json['is_open_exam'];
    isOpenTask = json['is_open_task'];
    minScore = json['min_score'];
    examQuiz = json['exam_quiz'];
    employeeCourse = json['employee_course'] != null
        ? (json['employee_course'] as List)
            .map((e) => EmployeeCourseData.fromJson(e))
            .toList()
        : null;
    employeeBookmark = json['employee_bookmark'] != null
        ? (json['employee_bookmark'] as List)
            .map((e) => CourseBookmarkByEmployee.fromJson(e))
            .toList()
        : null;
    image = json['image'] != null ? ImageData.fromJson(json['image']) : null;
    description = json['description'];
    taskDescription = json['task_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['user_created'] = userCreated;
    data['date_created'] = dateCreated;
    data['user_updated'] = userUpdated;
    data['date_updated'] = dateUpdated;
    data['title'] = title;
    data['activities'] = activities;
    data['duration'] = duration;
    data['material_content'] = materialContent;
    data['video_content'] = videoContent;
    data['is_open_exam'] = isOpenExam;
    data['is_open_task'] = isOpenTask;
    data['min_score'] = minScore;
    data['exam_quiz'] = examQuiz;
    data['employee_course'] = employeeCourse;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['description'] = description;
    data['task_description'] = taskDescription;
    return data;
  }
}

class ActivitiesData {
  String? id;
  String? title;

  ActivitiesData({
    this.id,
    this.title,
  });

  ActivitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

class ImageData {
  String? id;
  String? storage;
  String? filenameDisk;
  String? filenameDownload;
  String? title;
  String? type;
  dynamic folder;
  String? uploadedBy;
  String? uploadedOn;
  dynamic modifiedBy;
  String? modifiedOn;
  dynamic charset;
  int? filesize;
  int? width;
  int? height;
  dynamic duration;
  dynamic embed;
  dynamic description;
  dynamic location;
  dynamic tags;
  Map<String, dynamic>? metadata;
  dynamic focalPointX;
  dynamic focalPointY;

  ImageData({
    this.id,
    this.storage,
    this.filenameDisk,
    this.filenameDownload,
    this.title,
    this.type,
    this.folder,
    this.uploadedBy,
    this.uploadedOn,
    this.modifiedBy,
    this.modifiedOn,
    this.charset,
    this.filesize,
    this.width,
    this.height,
    this.duration,
    this.embed,
    this.description,
    this.location,
    this.tags,
    this.metadata,
    this.focalPointX,
    this.focalPointY,
  });

  ImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storage = json['storage'];
    filenameDisk = json['filename_disk'];
    filenameDownload = json['filename_download'];
    title = json['title'];
    type = json['type'];
    folder = json['folder'];
    uploadedBy = json['uploaded_by'];
    uploadedOn = json['uploaded_on'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    charset = json['charset'];
    filesize = json['filesize'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    embed = json['embed'];
    description = json['description'];
    location = json['location'];
    tags = json['tags'];
    metadata = json['metadata'];
    focalPointX = json['focal_point_x'];
    focalPointY = json['focal_point_y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['storage'] = storage;
    data['filename_disk'] = filenameDisk;
    data['filename_download'] = filenameDownload;
    data['title'] = title;
    data['type'] = type;
    data['folder'] = folder;
    data['uploaded_by'] = uploadedBy;
    data['uploaded_on'] = uploadedOn;
    data['modified_by'] = modifiedBy;
    data['modified_on'] = modifiedOn;
    data['charset'] = charset;
    data['filesize'] = filesize;
    data['width'] = width;
    data['height'] = height;
    data['duration'] = duration;
    data['embed'] = embed;
    data['description'] = description;
    data['location'] = location;
    data['tags'] = tags;
    data['metadata'] = metadata;
    data['focal_point_x'] = focalPointX;
    data['focal_point_y'] = focalPointY;
    return data;
  }
}

class CategoryData {
  final String? id;
  final String? createdBy;
  final DateTime? dateCreated;
  final String? updatedBy;
  final DateTime? dateUpdated;
  final String? name;
  final String? image;

  CategoryData({
    this.id,
    this.createdBy,
    this.dateCreated,
    this.updatedBy,
    this.dateUpdated,
    this.name,
    this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      createdBy: json['created_by'],
      dateCreated: DateTime.parse(json['date_created']),
      updatedBy: json['updated_by'],
      dateUpdated: json['date_updated'] != null
          ? DateTime.parse(json['date_updated'])
          : null,
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'date_created': dateCreated,
      'updated_by': updatedBy,
      'date_updated': dateUpdated,
      'name': name,
      'image': image,
    };
  }
}

class CourseBookmarkByEmployee {
  final String? id;
  final String? userCreated;
  final DateTime? dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String? course;
  final String? employee;

  CourseBookmarkByEmployee({
    this.id,
    this.userCreated,
    this.dateCreated,
    this.userUpdated,
    this.dateUpdated,
    this.course,
    this.employee,
  });

  factory CourseBookmarkByEmployee.fromJson(Map<String, dynamic> json) {
    return CourseBookmarkByEmployee(
      id: json['id'],
      userCreated: json['user_created'],
      dateCreated: json['date_created'] != null
          ? DateTime.parse(json['date_created'])
          : null,
      userUpdated: json['user_updated'],
      dateUpdated: json['date_updated'] != null
          ? DateTime.parse(json['date_updated'])
          : null,
      course: json['course'],
      employee: json['employee_id'],
    );
  }
}

class EmployeeCourseData {
  final String? id;
  final String? userCreated;
  final DateTime? dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String? course;
  final bool? completed;
  final String? employee;
  final dynamic examScore;
  final dynamic tasksScore;
  final dynamic lastVideoDuration;
  final dynamic videoDuration;
  final List<dynamic>? tasks;

  EmployeeCourseData({
    this.id,
    this.userCreated,
    this.dateCreated,
    this.userUpdated,
    this.dateUpdated,
    this.course,
    this.completed,
    this.employee,
    this.examScore,
    this.tasksScore,
    this.lastVideoDuration,
    this.videoDuration,
    this.tasks,
  });

  factory EmployeeCourseData.fromJson(Map<String, dynamic> json) {
    return EmployeeCourseData(
      id: json['id'],
      userCreated: json['user_created'],
      dateCreated: json['date_created'] != null
          ? DateTime.parse(json['date_created'])
          : null,
      userUpdated: json['user_updated'],
      dateUpdated: json['date_updated'] != null
          ? DateTime.parse(json['date_updated'])
          : null,
      course: json['course'] ?? '',
      completed: json['completed'],
      employee: json['employee'],
      examScore: json['exam_score'],
      tasksScore: json['tasks_score'],
      lastVideoDuration: json['last_video_duration'],
      videoDuration: json['video_duration'],
      tasks: json['tasks'] ?? [],
    );
  }
}

class ResponseCourseByEmployee {
  final List<CourseByEmployee>? data;

  ResponseCourseByEmployee({
    this.data,
  });

  factory ResponseCourseByEmployee.fromJson(Map<String, dynamic> json) {
    return ResponseCourseByEmployee(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => CourseByEmployee.fromJson(e))
              .toList()
          : null,
    );
  }
}

class CourseByEmployee {
  String? id;
  CourseData? course;
  bool? completed;
  int? examScore;
  int? tasksScore;
  int? lastVideoDuration;
  int? examAttempt;
  List<Task>? tasks;

  CourseByEmployee({
    this.id,
    this.course,
    this.completed,
    this.examAttempt,
    this.tasks,
    this.examScore,
    this.tasksScore,
    this.lastVideoDuration,
  });

  factory CourseByEmployee.fromJson(Map<String, dynamic> json) {
    return CourseByEmployee(
      id: json['id'],
      course: CourseData.fromJson(json['course']),
      completed: json['completed'],
      examScore: json['exam_score'],
      tasksScore: json['tasks_score'],
      lastVideoDuration: json['last_video_duration'],
      examAttempt: json['exam_attempt'],
      tasks: List<Task>.from(json['tasks'].map((task) => Task.fromJson(task))),
    );
  }
}

class Task {
  int? id;
  ImageData? directusFilesId;

  Task({
    this.id,
    this.directusFilesId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      directusFilesId: json['directus_files_id'] != null
          ? ImageData.fromJson(json['directus_files_id'])
          : null,
    );
  }
}
