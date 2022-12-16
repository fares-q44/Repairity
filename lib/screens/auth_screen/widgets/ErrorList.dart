import 'package:flutter/material.dart';

class ErrorList extends StatelessWidget {
  const ErrorList({
    Key? key,
    required this.errorTextList,
    required this.sWidth,
  }) : super(key: key);

  final List<String> errorTextList;
  final double sWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: errorTextList.length,
      itemBuilder: (context, index) => Row(
        children: [
          SizedBox(
            width: sWidth * 0.04,
          ),
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(
            ' ${errorTextList[index]}',
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
