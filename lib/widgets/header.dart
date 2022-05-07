import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'สวัสดี Header',
      style: TextStyle(color: Colors.blue, fontSize: 40),
    );
  }
}
