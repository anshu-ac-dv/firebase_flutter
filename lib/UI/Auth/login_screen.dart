import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/UI/Auth/login_with_phone.dart';
import 'package:flutter_firebase/UI/Auth/sign_up.dart';
import 'package:flutter_firebase/UI/Auth/welcome.dart';
import 'package:flutter_firebase/Utilits/errorToast.dart';
import 'package:flutter_firebase/Widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });
    auth
        .signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        )
        .then((value) {
          setState(() {
            loading = false;
          });
          Errortoast().SuccessToast("Login Successfully");
          Navigator.push(
            (context),
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        })
        .onError((error, stackTrace) {
          debugPrint(error.toString());
          Errortoast().showToast(error.toString());
          setState(() {
            loading = false;
          });
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                child: Text("Please login to get more benefits."),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Text(
                  "Login Now",
                  style: GoogleFonts.oswald(fontSize: 25, color: Colors.black),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.purpleAccent.shade700,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.purpleAccent.shade700,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.password_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.purpleAccent.shade700,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.purpleAccent.shade700,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Button(
                  title: "Login",
                  onPressed: () {
                    loading = loading;
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
              // Center(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.purpleAccent.shade700,
              //       ),
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: TextButton(onPressed: (){
              //       Navigator.push(
              //         (context),
              //         MaterialPageRoute(builder: (context) => LoginWithPhone()),
              //       );
              //     }, child: Text("Login With Phone")),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
