import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/model/quiz.dart';
import 'package:haleyora/services/dio_client.dart';

class QuizController extends GetxController {
  var complete = false;
  var questionIndex = 0.obs;
  var score = 0.obs;
  Timer? timer;
  var startDuration = 0.obs; // in seconds
  var scorePerQuestion = 0.obs;
  var isStart = false.obs;
  var questionList = <QuizQuestion>[].obs;
  var answerList = [].obs;

  @override
  void onInit() {
    print('init quiz');
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void resetQuiz() {
    complete = false;
    questionIndex.value = 0;
    score.value = 0;
    startDuration.value = 0;
    scorePerQuestion.value = 0;
    isStart.value = false;
    questionList.clear();
    answerList.clear();
  }

  Future<void> fetchQuiz(String quizId) async {
    try {
      final result = await dio.get(
          '/items/quiz/$quizId?fields[]=title,duration,score_per_question,randomize,quiz_question.title,quiz_question.image, quiz_question.choices,quiz_question.answer');
      Quiz quizQuestion = Quiz.fromJson(result.data['data']);
      startDuration.value = quizQuestion.duration!;
      if (quizQuestion.randomize!) {
        quizQuestion.quizQuestions!.shuffle();
      }
      questionList.value = quizQuestion.quizQuestions!;
      scorePerQuestion.value = quizQuestion.scorePerQuestion!;
    } catch (e) {
      print('error fetchQuiz: $e');
    }
  }

  void saveAnswerToIndex(String answer, int index) {
    answerList.insert(index, answer);
  }

  Future<void> checkAnswer(String courseId) async {
    AuthController authController = Get.find<AuthController>();
    try {
      for (int i = 0; i < questionList.length; i++) {
        if (questionList[i].answer == answerList[i]) {
          score.value += scorePerQuestion.value;
        }
      }
      complete = true;
      await dio.patch('/items/employee_course', data: {
        "query": {
          "filter": {
            "employee": {
              "_eq": authController.currentUser.value.employeeData!.id
            },
            "course": {"_eq": courseId}
          }
        },
        "data": {
          "exam_score": score.value,
          "completed": true,
          "exam_attempt": 2
        }
      });
    } catch (e) {
      print('error checkAnswer: $e');
    }
  }

  // void removeAnswer(String answer, int index) {
  //   answerList.removeAt(index);
  // }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (isStart.value == false) {
          timer.cancel();
        } else {
          startDuration.value--;
        }
      },
    );
  }

  void startQuiz() {
    startTimer();
    isStart.value = true;
  }
}
