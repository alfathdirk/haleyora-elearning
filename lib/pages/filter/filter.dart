import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/course.dart';

class FilterPage extends StatelessWidget {
  FilterPage({super.key});
  CourseController courseController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(courseController.categoryList.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => courseController.listFilter.clear(),
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text('Clear',
                  style: GoogleFonts.mulish(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bidang Pekerjaan:',
                style: GoogleFonts.mulish(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: courseController.categoryList.length,
                  itemBuilder: (context, index) {
                    return Obx(() => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            courseController.categoryList[index].name,
                            style: GoogleFonts.mulish(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: courseController.listFilter.contains(
                              courseController.categoryList[index].id),
                          onChanged: (value) {
                            if (value == true) {
                              courseController.listFilter
                                  .add(courseController.categoryList[index].id);
                              return;
                            }
                            courseController.listFilter.remove(
                                courseController.categoryList[index].id);
                          },
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
