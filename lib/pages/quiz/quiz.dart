import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/widget/card.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key}) : super(key: key);
  final QuizController controller = Get.put(QuizController());

  // initialize question
  Future<void> init() async {
    // check id from previous page
    controller.setQuestionList([
      Question(
        question: "What is the capital city of Indonesia?",
        file: "https://picsum.photos/200/300?random=1",
        answer: [
          Answer(key: "A", value: "Jakarta"),
          Answer(key: "B", value: "Bandung"),
          Answer(key: "C", value: "Bogor"),
          Answer(key: "D", value: "Bali"),
        ],
        correctAnswer: "A",
      ),
      Question(
        question: "What is the capital?",
        file: "https://picsum.photos/200/300?random=2",
        answer: [
          Answer(key: "A", value: "Capital Is"),
          Answer(key: "B", value: "Awesome"),
          Answer(key: "C", value: "Good"),
          Answer(key: "D", value: "Keren"),
        ],
        correctAnswer: "C",
      ),
      Question(
        question: "What is the capital city of Thailand?",
        file: "https://picsum.photos/200/300?random=3",
        answer: [
          Answer(key: "A", value: "Jakarta"),
          Answer(key: "B", value: "Bangkok"),
          Answer(key: "C", value: "Kuala Lumpur"),
          Answer(key: "D", value: "Bali"),
        ],
        correctAnswer: "B",
      ),
    ]);
    // controller.totalQuestion.value = questions.length;
    // controller.startQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
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
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            value: controller.questionIndex.toInt() /
                                controller.questionList.length.toDouble(),
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${controller.questionIndex.toInt() + 1}/${controller.questionList.length}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.timer,
                        color: controller.start < 10 ? Colors.red : orangeText,
                        size: 12,
                      ),
                      Text(
                        // timer minute
                        "${(controller.start.toInt() / 60).floor()}:${(controller.start % 60).toString().padLeft(2, '0')}",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color:
                              controller.start < 10 ? Colors.red : orangeText,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              controller
                                  .questionList[
                                      controller.questionIndex.toInt()]
                                  .question,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                },
                                controller
                                    .questionList[
                                        controller.questionIndex.toInt()]
                                    .file!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: controller
                                .questionList[controller.questionIndex.toInt()]
                                .answer
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CustomCard(
                                      color: controller.selectedValue
                                                  .asMap()
                                                  .containsKey(e.key) &&
                                              controller.selectedValue[
                                                      controller.questionIndex
                                                          .toInt()] ==
                                                  e.key
                                          ? Colors.blue
                                          : Colors.white,
                                      child: ListTile(
                                        title: Text(
                                          "${e.key}. ${e.value}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: controller.selectedValue
                                                        .asMap()
                                                        .containsKey(e.key) &&
                                                    controller.selectedValue[
                                                            controller
                                                                .questionIndex
                                                                .toInt()] ==
                                                        e.key
                                                ? Colors.white
                                                : Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        onTap: () => {
                                          controller.answerQuestion(
                                              controller.questionIndex.toInt(),
                                              e.key)
                                        },
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: RoundedButton(
                    text: controller.questionIndex.toInt() ==
                            controller.questionList.length - 1
                        ? "Finish"
                        : "Next",
                    onPressed: () {
                      if (controller.questionIndex.toInt() ==
                          controller.questionList.length - 1) {
                        Get.offAllNamed("/home");
                        return;
                      }
                      controller.nextQuestion();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
