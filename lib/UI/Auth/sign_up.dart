import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/Auth/login_screen.dart';
import 'package:flutter_firebase/Widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/Utilits/errorToast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    FirebaseAuth auth = FirebaseAuth.instance;

    void dispose() {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    void register() {
      setState(() {
        loading = true;
      });
      auth
          .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString(),
          )
          .then((onValue) {
            setState(() {
              loading = false;
            });
          })
          .onError((error, stackTrace) {
            Errortoast().showToast(error.toString());
            setState(() {
              loading = false;
            });
          });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: const Icon(Icons.drive_file_rename_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.password),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please create your password";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Button(
              loading: loading,
              title: "Register Now",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  register();
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    (context),
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text("Login Now"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
