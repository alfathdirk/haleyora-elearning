import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchController extends GetxController {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final searchResults = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchFocusNode.requestFocus();
  }

  void onSearchTextChanged(String text) {
    // searchResults.clear();
    // if (text.isEmpty) {
    //   return;
    // }
    // searchResults.addAll(
    //   List.generate(10, (index) => '$text $index'),
    // );
  }

  void onSearchResultSelected(String result) {
    searchController.text = result;
    searchFocusNode.unfocus();
  }
}
