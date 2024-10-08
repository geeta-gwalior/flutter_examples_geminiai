import 'package:flutter/material.dart';



class SingleSelectionChipWidget extends StatefulWidget {
  @override
  _SingleSelectionChipWidgetState createState() => _SingleSelectionChipWidgetState();
}

class _SingleSelectionChipWidgetState extends State<SingleSelectionChipWidget> {
  int _selectedChipIndex = 0;
  final List<String> _chipOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: List<Widget>.generate(
        _chipOptions.length,
            (int index) {
          return ChoiceChip(
            label: Text(_chipOptions[index]),
            selected: _selectedChipIndex == index,
            onSelected: (bool selected) {
              setState(() {
                _selectedChipIndex = selected ? index : _selectedChipIndex;
              });
            },
          );
        },
      ).toList(),
    );
  }
}
