import 'package:get/get.dart';
import 'package:haleyora/services/dio_client.dart';

class TNCController extends GetxController {
  final tncData = ''.obs;

  @override
  void onInit() async {
    await getTnc();
    super.onInit();
  }

  Future<void> getTnc() async {
    try {
      final result = await dio.get('/items/term_condition');
      TNCResponse response = TNCResponse.fromJson(result.data['data']);
      tncData.value = response.data[0].description;
    } catch (e) {
      print('error notif: $e');
    }
  }
}

class TNCResponse {
  final List<TNCData> data;

  TNCResponse({required this.data});

  factory TNCResponse.fromJson(List<dynamic> json) {
    return TNCResponse(
      data: json.map((e) => TNCData.fromJson(e)).toList(),
    );
  }
}

class TNCData {
  final String description;

  TNCData({
    required this.description,
  });

  factory TNCData.fromJson(Map<String, dynamic> json) {
    return TNCData(
      description: json['description'],
    );
  }
}
