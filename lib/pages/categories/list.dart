import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/category.dart';
import 'package:haleyora/widget/card.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() {
    return _CategoryListPage();
  }
}

class _CategoryListPage extends State<CategoryListPage> {
  bool isChoose = true;
  bool isBack = false;
  CategoryController categoryController = Get.put(CategoryController());

  var paramId = Get.parameters['categoryId']!;

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Bidang Kategori",
            style: GoogleFonts.jost(
                fontSize: 20.sp, fontWeight: FontWeight.bold, color: darkText)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (categoryController.currentPage.value == 0) {
              Get.back();
              return;
            }
            categoryController.currentPage.value -= 1;
            setState(() {
              paramId = categoryController.ids.last;
              isChoose = false;
              isBack = true;
            });
            Future.delayed(const Duration(milliseconds: 200), () {
              categoryController.ids.removeLast();
              setState(() {
                isChoose = true;
              });
            });
          },
        ),
      ),
      body: PageTransitionSwitcher(
          reverse: isBack, // uncomment to see transition in reverse
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (
            Widget child,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: isChoose
              ? ListCategory(
                  id: paramId,
                  type: categoryController
                      .categoryPage[categoryController.currentPage.value],
                  onTap: (category, id) {
                    categoryController.ids.add(paramId);
                    setState(() {
                      isChoose = false;
                      paramId = id;
                      isBack = false;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      setState(() {
                        isChoose = true;
                      });
                    });
                  })
              : const SizedBox()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }
}

class ListCategory extends StatelessWidget {
  final String id;
  final String type;
  final void Function(String type, String id)? onTap;
  CategoryController categoryController = Get.find<CategoryController>();

  ListCategory({
    this.id = '',
    this.onTap,
    this.type = '',
    super.key,
  });

  Future<void> initCategory() async {
    // await categoryController.getSubCategoryById(id);
    switch (type) {
      case 'sub_sector':
        print('default 2');
        categoryController.currentPage.value = 1;
        await categoryController.getSubCategory(id);
        break;
      case 'activities':
        categoryController.currentPage.value = 2;
        await categoryController.getActivity(id);
        break;
      default:
        print('default 1');
        categoryController.currentPage.value = 0;
        await categoryController.getSubCategoryById(id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return buildScafold(context);
        }
      },
    );
  }

  Widget buildScafold(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: CustomCard(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryController.categoryList.length,
                itemBuilder: (context, index) {
                  CategoryOption data = categoryController.categoryList[index];
                  return ListTile(
                    title: Text(data.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.mulish(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      if (categoryController.currentPage.value >= 2) {
                        Get.toNamed('/search-result', arguments: {
                          'activityId': data.id,
                          'isFromCategory': true
                        });
                        return;
                      }
                      categoryController.currentPage.value += 1;
                      onTap?.call('category', data.id);
                    },
                  );
                },
              )),
        ));
  }
}
