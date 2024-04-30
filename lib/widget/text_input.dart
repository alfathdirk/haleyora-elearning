import 'package:flutter/material.dart';

class TextFieldWithBoxShadow extends StatelessWidget {
  final String? errorText;
  final String? labelText;
  final TextEditingController? controller;
  final Icon? icon;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final String? placeholder;

  const TextFieldWithBoxShadow({
    Key? key,
    this.errorText,
    this.labelText,
    this.controller,
    this.icon,
    this.isPassword,
    this.validator,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(95, 165, 165, 165),
              blurRadius: 25,
              spreadRadius: 0,
              offset: Offset(0, 0)),
        ],
      ),
      child: TextFormField(
        obscureText: isPassword ?? false,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          errorText: errorText,
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          hintText: placeholder,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
