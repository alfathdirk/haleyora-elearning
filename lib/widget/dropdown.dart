import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final Function(dynamic) onChanged;
  final String? placeholder;
  dynamic value;

  DropdownWidget(
      {required this.options,
      required this.onChanged,
      this.placeholder,
      this.value});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  dynamic initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(95, 165, 165, 165),
            blurRadius: 25,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isExpanded: true,
            value: widget.value != '' ? widget.value : initialValue,
            hint: Text(widget.placeholder ?? 'Select an option'),
            items: widget.options.map((option) {
              return DropdownMenuItem(
                value: option['key'],
                child: Text(option['label']),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.value = value;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}
