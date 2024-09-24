import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/model/quiz.dart';
import 'package:haleyora/widget/button.dart';

class QuizCard extends StatelessWidget {
  final String question;
  final List<QuizChoice> choices;
  final Function(String) onSelected;
  final int? isSelectedIndex;

  const QuizCard({
    super.key,
    required this.question,
    required this.choices,
    required this.onSelected,
    this.isSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: choices.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  onSelected(choices[index].id!);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelectedIndex == index
                        ? Colors.blue[400]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelectedIndex == index
                          ? Colors.blue[400]!
                          : Colors.white,
                    ),
                  ),
                  child: Text(
                    choices[index].label!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelectedIndex == index
                          ? Colors.white
                          : Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
