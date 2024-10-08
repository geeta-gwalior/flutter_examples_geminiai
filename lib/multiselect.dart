import 'package:flutter/material.dart';

class MultipleSelectionChipWidget extends StatefulWidget {
  @override
  _MultipleSelectionChipWidgetState createState() => _MultipleSelectionChipWidgetState();
}

class _MultipleSelectionChipWidgetState extends State<MultipleSelectionChipWidget> {
  List<String> _selectedChoices = [];
  final List<String> _chipOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: _chipOptions.map((String option) {
        return FilterChip(
          label: Text(option),
          selected: _selectedChoices.contains(option),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedChoices.add(option);
              } else {
                _selectedChoices.removeWhere((String name) {
                  return name == option;
                });
              }
            });
          },
        );
      }).toList(),
    );
  }
}