import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(95, 165, 165, 165),
            blurRadius: 11,
            spreadRadius: 0.2,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}
