import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const Button({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: onPressed,
        child: Container(
          height: 2,
          decoration: BoxDecoration(
            color: Colors.purpleAccent.shade700,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
