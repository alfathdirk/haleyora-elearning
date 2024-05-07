import 'package:get/get.dart';
import 'package:haleyora/services/dio_client.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var isChoose = false.obs;
  var categoryList = [].obs;
  var currentPage = 0.obs;
  var categoryPage = ['sector', 'sub_sector', 'activities'];
  var ids = [].obs;

  // Sector
  Future<void> getSubCategoryById(String catId) async {
    try {
      isLoading(true);
      final result =
          await dio.get('/items/sector?filter[category_id][_eq]=$catId');
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(result.data['data']);
      categoryList.value = categoryResponse.data.toList();
      isLoading(false);
    } catch (e) {
      print('error getCategoryById: $e');
    }
  }

  // Sub Sector
  Future<void> getSubCategory(String subCategoryId) async {
    print('/items/sub_sector?fields[]=*&filter[sector_id][_eq]=$subCategoryId');
    try {
      final result = await dio.get(
          '/items/sub_sector?fields[]=*&filter[sector_id][_eq]=$subCategoryId');
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(result.data['data']);
      categoryList.value = categoryResponse.data.toList();
    } catch (e) {
      print('error getCategory: $e');
    }
  }

  // Activity
  Future<void> getActivity(String sectorId) async {
    try {
      final result = await dio.get(
          '/items/activities?fields[]=*&filter[sub_sector][_eq]=$sectorId');
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(result.data['data']);
      categoryList.value = categoryResponse.data.toList();
    } catch (e) {
      print('error getCategory: $e');
    }
  }
}

class CategoryResponse {
  final List<CategoryOption> data;

  CategoryResponse({required this.data});

  factory CategoryResponse.fromJson(List<dynamic> json) {
    return CategoryResponse(
      data: json.map((e) => CategoryOption.fromJson(e)).toList(),
    );
  }
}

class CategoryOption {
  final String id;
  final String title;

  CategoryOption({required this.id, required this.title});

  factory CategoryOption.fromJson(Map<String, dynamic> json) {
    return CategoryOption(
      id: json['id'],
      title: json['title'],
    );
  }
}
