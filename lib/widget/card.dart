import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;

  const CustomCard(
      {Key? key,
      required this.child,
      this.height,
      this.width,
      this.radius,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 14),
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
