class Quiz {
  final String? title;
  final int? duration;
  final int? scorePerQuestion;
  final bool? randomize;
  final List<QuizQuestion>? quizQuestions;

  Quiz({
    this.title,
    this.duration,
    this.scorePerQuestion,
    this.randomize,
    this.quizQuestions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    List<dynamic> questionsList = json['quiz_question'];
    List<QuizQuestion> parsedQuestions = questionsList
        .map((question) => QuizQuestion.fromJson(question))
        .toList();

    return Quiz(
      title: json['title'],
      duration: json['duration'],
      scorePerQuestion: json['score_per_question'],
      randomize: json['randomize'],
      quizQuestions: parsedQuestions,
    );
  }
}

class QuizQuestion {
  final String? title;
  final String? image;
  final List<QuizChoice>? choices;
  final String? answer;

  QuizQuestion({
    this.title,
    this.image,
    this.choices,
    this.answer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    List<dynamic> choicesList = json['choices'];
    List<QuizChoice> parsedChoices =
        choicesList.map((choice) => QuizChoice.fromJson(choice)).toList();

    return QuizQuestion(
      title: json['title'],
      image: json['image'],
      choices: parsedChoices,
      answer: json['answer'],
    );
  }
}

class QuizChoice {
  final String? id;
  final String? label;

  QuizChoice({
    this.id,
    this.label,
  });

  factory QuizChoice.fromJson(Map<String, dynamic> json) {
    return QuizChoice(
      id: json['id'],
      label: json['label'],
    );
  }
}
