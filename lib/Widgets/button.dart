import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  const Button({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.purpleAccent.shade700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
