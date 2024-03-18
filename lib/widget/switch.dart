import 'package:flutter/material.dart';
import 'package:haleyora/constants.dart';

class SwitchCustom extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const SwitchCustom({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          trackColor: MaterialStateProperty.all(Colors.grey[200]),
          thumbColor: MaterialStateProperty.all(Colors.white),
          // This bool value toggles the switch.
          value: value,
          activeColor: primaryColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
