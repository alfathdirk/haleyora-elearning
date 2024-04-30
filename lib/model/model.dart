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
  String? minScore;
  dynamic examQuiz;
  List<String>? employeeCourse;
  ImageData? image;
  String? description;

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
    this.image,
    this.description,
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
        ? List<String>.from(json['employee_course'])
        : null;
    image = json['image'] != null ? ImageData.fromJson(json['image']) : null;
    description = json['description'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
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
