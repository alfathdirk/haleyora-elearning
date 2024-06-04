import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
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
  var hasOngoingQuiz = false.obs;
  var ongoingCourseId = ''.obs;
  var ongoingQuizId = ''.obs;

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
    complete = false.obs.value;
    questionIndex.value = 0.obs.value;
    score.value = 0.obs.value;
    startDuration.value = 0.obs.value;
    scorePerQuestion.value = 0.obs.value;
    isStart.value = false.obs.value;
    questionList.clear();
    answerList.clear();
    hasOngoingQuiz.value = false.obs.value;
    ongoingCourseId.value = ''.obs.value;
    ongoingQuizId.value = ''.obs.value;
    timer?.cancel();
  }

  Future<void> fetchQuiz(String quizId) async {
    try {
      final result = await dio.get(
          '/items/quiz/$quizId?fields[]=title,duration,score_per_question,randomize,quiz_question.title,quiz_question.image, quiz_question.choices,quiz_question.answer');
      Quiz quizQuestion = Quiz.fromJson(result.data['data']);

      if (questionList.isEmpty) {
        questionList.value = quizQuestion.quizQuestions!;
      }

      if (quizQuestion.randomize! && startDuration.value == 0) {
        quizQuestion.quizQuestions!.shuffle();
        questionList.value = quizQuestion.quizQuestions!;
      }

      scorePerQuestion.value = quizQuestion.scorePerQuestion!;

      if (startDuration.value == 0) {
        startDuration.value = quizQuestion.duration! * 60;
        hasOngoingQuiz.value = true;
        ongoingQuizId.value = quizId;
        startQuiz();
      }
    } catch (e) {
      print('error fetchQuiz: $e');
    }
  }

  void saveAnswerToIndex(String answer, int index) {
    answerList.insert(index, answer);
  }

  Future<void> checkAnswer(String courseId) async {
    AuthController authController = Get.find<AuthController>();
    CourseController courseController = Get.find<CourseController>();
    final courseByEmployee = courseController.courseByEmployee.value.data ?? [];

    try {
      for (int i = 0; i < answerList.length; i++) {
        if (questionList[i].answer == answerList[i]) {
          score.value += scorePerQuestion.value;
        }
      }
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
          "exam_score": courseByEmployee.first.examScore! >= score.value
              ? courseByEmployee.first.examScore
              : score.value,
          "exam_attempt": courseByEmployee.first.examAttempt! - 1,
          "completed": true,
        }
      });
    } catch (e) {
      print('error checkAnswer: $e');
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (timer) {
        if (startDuration.value == 0 && hasOngoingQuiz.value) {
          timer.cancel();
          complete = true;
          checkAnswer(ongoingCourseId.value);
          Get.defaultDialog(
            barrierDismissible: false,
            title: 'Waktu Habis',
            middleText: 'Ujian mu sudah selesai',
            onConfirm: () {
              Future.delayed(
                const Duration(milliseconds: 1000),
                () {
                  resetQuiz();
                },
              );
              Get.offAllNamed('/home');
            },
          );
          return;
        }
        startDuration.value--;
      },
    );
  }

  void startQuiz() {
    startTimer();
    isStart.value = true;
  }
}
