import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/model/quiz.dart';
import 'package:haleyora/pages/quiz/quiz_card.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/popup.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});
  final quizId = Get.parameters['quizId'];
  final courseId = Get.parameters['id'];
  QuizController controller = Get.find<QuizController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchQuiz(quizId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return quizView(context);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Scaffold quizView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Page"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Obx(
                          () => LinearProgressIndicator(
                            minHeight: 12,
                            value: controller.questionIndex.value +
                                1 / controller.questionList.length.toDouble(),
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(() => Text(
                        "${controller.questionIndex.toInt() + 1}/${controller.questionList.length}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.timer,
                    color:
                        controller.startDuration < 10 ? Colors.red : orangeText,
                    size: 12,
                  ),
                  Obx(() => Text(
                        // timer minute
                        "${(controller.startDuration / 60).floor().toString().padLeft(2, '0')}:${(controller.startDuration % 60).floor().toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: 8 < 10 ? Colors.red : orangeText,
                          decoration: TextDecoration.none,
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(
                      () => AnimatedSwitcher(
                        key: ValueKey(controller.questionIndex.value),
                        duration: const Duration(seconds: 1),
                        child:
                            controller
                                        .questionList[
                                            controller.questionIndex.value]
                                        .title !=
                                    null
                                ? Column(
                                    children: [
                                      Image.network(
                                        "${imageBaseUrl}${controller.questionList[controller.questionIndex.value].image!}?access_token=${box.read('accessToken')}",
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      QuizCard(
                                        isSelectedIndex: controller
                                                        .answerList.length >
                                                    controller
                                                        .questionIndex.value &&
                                                controller.answerList[controller.questionIndex.value] !=
                                                    null
                                            ? controller.answerList[controller.questionIndex.value] !=
                                                    null
                                                ? controller
                                                    .questionList[controller
                                                        .questionIndex.value]
                                                    .choices!
                                                    .indexWhere((element) =>
                                                        element.id ==
                                                        controller.answerList[controller.questionIndex.value])
                                                : null
                                            : null,
                                        question: controller
                                            .questionList[
                                                controller.questionIndex.value]
                                            .title!,
                                        choices: controller
                                            .questionList[
                                                controller.questionIndex.value]
                                            .choices!,
                                        onSelected: (value) {
                                          controller.saveAnswerToIndex(value,
                                              controller.questionIndex.value);
                                        },
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text(
                                        "No question found",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    )),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: () {
                      if (controller.questionIndex.value > 0) {
                        controller.questionIndex.value--;
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width - 60,
                  child: Obx(() => RoundedButton(
                        text: controller.questionIndex.toInt() ==
                                controller.questionList.length - 1
                            ? "Finish"
                            : "Next",
                        onPressed: () async {
                          if (controller.questionIndex.toInt() ==
                              controller.questionList.length - 1) {
                            await controller.checkAnswer(courseId!);
                            // print(controller.answerList);
                            Get.dialog(
                                ImageDialog(
                                  buttonText: "OK",
                                  onPressed: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      controller.resetQuiz();
                                    });

                                    Get.offAllNamed('/home');
                                  },
                                  image: "assets/images/distribusi.png",
                                  title:
                                      "Selamat anda telah menyelesaikan quiz",
                                ),
                                barrierDismissible: false);
                            return;
                          }
                          controller.questionIndex.value++;
                        },
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
