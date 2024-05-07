import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/model/me.dart';
import 'package:haleyora/services/dio_client.dart';

class NotificationController extends GetxController {
  final currentUser = ResponseData().obs;
  final listNotification = <NotificationData>[].obs;
  final box = GetStorage();

  @override
  void onInit() async {
    print('object');

    await getListNotification();
    super.onInit();
  }

  Future<void> getListNotification() async {
    try {
      print('get notif fetched...');
      final result = await dio.get(
          '/items/notification?filter[employee_id][_eq]=${box.read('employee_id')}');
      NotificationsResponse response =
          NotificationsResponse.fromJson(result.data['data']);
      listNotification.value = response.data;
      // print(response.data);
    } catch (e) {
      print('error notif: $e');
    }
  }

  Future<void> readNotification(String id) async {
    try {
      await dio.patch('/items/notification/$id', data: {'is_read': true});
    } catch (e) {
      print('error read notif: $e');
    }
  }
}

class NotificationsResponse {
  final List<NotificationData> data;

  NotificationsResponse({required this.data});

  factory NotificationsResponse.fromJson(List<dynamic> json) {
    return NotificationsResponse(
      data: json.map((e) => NotificationData.fromJson(e)).toList(),
    );
  }
}

class NotificationData {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final bool? isRead;

  NotificationData({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: DateTime.parse(json['date_created']),
      isRead: json['is_read'],
    );
  }
}
