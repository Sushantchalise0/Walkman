import 'package:flutter/material.dart';

class MyFilterChip extends StatefulWidget {
  final String label;
  MyFilterChip({
    @required this.label,
  });

  @override
  _MyFilterChipState createState() => _MyFilterChipState();
}

class _MyFilterChipState extends State<MyFilterChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: FilterChip(
        showCheckmark: false,
        onSelected: (selected) {
          setState(() {
            isSelected = selected;
          });
        },
        selected: isSelected,
        label: Text(widget.label),
        labelStyle: isSelected
            ? TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              )
            : TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
              ),
        backgroundColor: Color(0xFF003B1A),
        selectedColor: Colors.white,
      ),
    );
  }
}
