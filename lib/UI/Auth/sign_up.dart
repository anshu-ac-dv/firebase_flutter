import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40),
            child: Text(
              "Welcome",
              style: GoogleFonts.oswald(
                fontSize: 35,
                color: Colors.purpleAccent.shade700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("You are new user. Please sign up."),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Register Now",
              style: GoogleFonts.oswald(fontSize: 25, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
