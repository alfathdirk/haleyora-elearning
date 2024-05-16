import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool isDisabled;
  final bool isLoading;
  final MainAxisAlignment align;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.isDisabled = false,
    this.isLoading = false,
    this.align = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          backgroundColor: isDisabled ? Colors.grey : color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        onPressed: isDisabled || isLoading ? () {} : onPressed,
        child: Row(
          mainAxisAlignment: align,
          children: [
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            SizedBox(width: isLoading ? 10 : 0),
            Text(
              text,
              style: GoogleFonts.jost(
                  fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
            ),
          ],
        ));
  }
}
