import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizController extends GetxController {
  var complete = false;
  var questionIndex = 0.obs;
  var score = 0.obs;
  Timer? timer;
  var start = 70.obs;
  var isStart = false.obs;
  var selectedValue = <String>[].obs;

  List<Question> questionList = <Question>[];

  void onInit() {
    print('init quiz');
    super.onInit();
  }

  void answerQuestion(int questionIndex, String answer) {
    selectedValue.insert(questionIndex, answer);
  }

  void reset() {
    questionIndex.value = 0;
    score.value = 0;
  }

  void nextQuestion() {
    questionIndex.value++;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
  }

  void startQuiz() {
    reset();
    startTimer();
    isStart.value = true;
  }

  void setQuestionList(List<Question> questionList) {
    this.questionList = questionList;
  }
}

class Answer {
  final String key;
  final String value;

  Answer({required this.key, required this.value});
}

class Question {
  final String question;
  final String correctAnswer;
  final String? file;
  final List<Answer> answer;

  Question({
    required this.question,
    required this.answer,
    required this.correctAnswer,
    this.file,
  });
}

class RoundedCard extends StatelessWidget {
  final Widget child;
  final Color color;

  const RoundedCard({
    Key? key,
    required this.child,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
