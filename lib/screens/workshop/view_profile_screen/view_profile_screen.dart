import 'package:flutter/material.dart';
import 'package:repairity/widgets/top_notch.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
      ],
    );
  }
}
