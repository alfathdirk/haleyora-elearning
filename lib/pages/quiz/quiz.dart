import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';
import 'dart:async';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentStep = 0;
  int _totalStep = 10;
  bool _complete = false;

  List<Question> questions = [
    Question(
      question: "Apa warna langit?",
      file: "https://picsum.photos/200/300?random=1",
      answer: [
        "Biru",
        "Merah",
        "Kuning",
        "Hijau",
        "Putih",
        "Hitam",
        "Ungu",
        "Pink"
      ],
      correctAnswer: "Biru",
    ),
    Question(
      question: "Apa warna rumput?",
      file: "https://picsum.photos/200/300?random=1",
      answer: ["Biru", "Merah", "Kuning", "Hijau"],
      correctAnswer: "Hijau",
    ),
    Question(
      question: "Apa warna matahari?",
      file: "https://picsum.photos/200/300?random=1",
      answer: ["Biru", "Merah", "Kuning", "Hijau"],
      correctAnswer: "Kuning",
    ),
  ];

  Timer? _timer;
  int _start = 70;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _complete = false;
    _totalStep = questions.length;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          value: _currentStep / _totalStep,
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "$_currentStep/$_totalStep",
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
                      color: _start < 10 ? Colors.red : orangeText,
                      size: 12,
                    ),
                    Text(
                      // timer minute
                      "${(_start / 60).floor()}:${(_start % 60).toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _start < 10 ? Colors.red : orangeText,
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
                            questions[_currentStep].question,
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
                              questions[_currentStep].file!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: questions[_currentStep]
                              .answer
                              .map((e) => GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        e,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                    ),
                                  ))
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
                  text: "Next",
                  onPressed: () {
                    setState(() {
                      if (_currentStep < _totalStep - 1) {
                        _currentStep++;
                      } else {
                        _complete = true;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ));
    //   return SafeArea(
    //       child: SizedBox(
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "Quiz Page",
    //               style: GoogleFonts.poppins(
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.w600,
    //                 color: Colors.black,
    //                 decoration: TextDecoration.none,
    //               ),
    //             ),
    //             IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
    //           ],
    //         ),
    //         Column(
    //           children: [
    //             const SizedBox(
    //               height: 80,
    //             ),
    //             ClipRRect(
    //               borderRadius: BorderRadius.circular(10),
    //               child: LinearProgressIndicator(
    //                 minHeight: 12,
    //                 value: _currentStep / _totalStep,
    //                 backgroundColor: Colors.grey[300],
    //                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //           ],
    //         ),
    //         SingleChildScrollView(
    //           child: Container(
    //             height: MediaQuery.of(context).size.height / 2,
    //             child: Column(
    //               children: [
    //                 Text(
    //                   "Soal ke $_currentStep dari $_totalStep",
    //                   style: GoogleFonts.poppins(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.black,
    //                     decoration: TextDecoration.none,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //                 Text(
    //                   questions[_currentStep].question,
    //                   style: GoogleFonts.poppins(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.black,
    //                     decoration: TextDecoration.none,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(10),
    //                   child: Image.network(
    //                     questions[_currentStep].file!,
    //                     width: double.infinity,
    //                     height: 200,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ));
  }
}

class Question {
  final String question;
  final List<String> answer;
  final String correctAnswer;
  final String? file;

  Question({
    required this.question,
    required this.answer,
    required this.correctAnswer,
    this.file,
  });
}
