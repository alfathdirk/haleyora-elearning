import 'package:flutter/material.dart';
import 'package:haleyora/constants.dart';

class SwitchCustom extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const SwitchCustom({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          trackOutlineColor: MaterialStateProperty.all(Colors.grey[200]),
          // trackColor: MaterialStateProperty.all(Colors.grey[200]),
          // activeTrackColor: primaryColor,
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
