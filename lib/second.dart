import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key, required this.payload});
  String? payload;

  @override
  Widget build(BuildContext context) {
    return Text("hello");
  }
}
