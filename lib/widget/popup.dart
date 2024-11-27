import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';

class ImageDialog extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final String image;
  final String title;

  const ImageDialog({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.47,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: backgroundWhite,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                Image.asset(image,
                    width: MediaQuery.of(context).size.width * 0.35),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mulish(
                        fontSize: 18.sp,
                        color: darkText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                RoundedButton(text: buttonText, onPressed: onPressed)
              ],
            )));
  }
}

class RaisedButton {}
