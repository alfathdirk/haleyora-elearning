import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/tnc.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsAndConditions extends StatelessWidget {
  TNCController tncController = Get.put(TNCController());
  Future<void> init() async {
    try {
      await tncController.getTnc();
    } catch (e) {
      print('error getTermCondition: $e');
    }
    // init function
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return buildScafold(context);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buildScafold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(() => Html(data: tncController.tncData.value)),
        ),
      ),
    );
  }
}
