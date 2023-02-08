import 'package:flutter/material.dart';

class FeqraDropdownButton extends StatefulWidget {
  final ValueChanged<String> onSelectChanged;
  const FeqraDropdownButton({
    Key? key,
    required this.list,
    required this.defaultValue,
    required this.onSelectChanged
  }) : super(key: key);
  final List<String> list;
  final String defaultValue;

  @override
  State<FeqraDropdownButton> createState() => _FeqraDropdownButtonState();
}

class _FeqraDropdownButtonState extends State<FeqraDropdownButton> {
  String dropdownValue = '';

  @override
  void initState() {
    dropdownValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onSelectChanged(dropdownValue);
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
