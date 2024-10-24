import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const Text(
          "promilo",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      "Hi, Welcome Back!",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    const Text('   Please Sign in to Continue'),
                    const SizedBox(height: 4),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          RegExp mobileNoRegex = RegExp(r'^\d{10}');
                          if (mobileNoRegex.hasMatch(value)) {
                            log('mobile number entered...');
                            return 'Please enter Email to validate';
                          } else if (EmailValidator.validate(value) && value.contains('test@stanch.io')) {
                            return null;
                          } else {
                            return 'Please enter valid Email or Mob No';
                          }
                        }
                        return "Please enter valid Email or Mob No";
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Enter Email or Mob No.",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Sign in with OTP action
                        },
                        child: const Text(
                          "Sign In With OTP",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('   Password'),
                    const SizedBox(height: 4),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty && value.contains('Test@123')) {
                          return null;
                        }
                        return "Please enter valid password";
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: null,
                        labelText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (bool? value) {}),
                            const Text("Remember Me"),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Forget password action
                          },
                          child: const Text(
                            "Forget Password",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Submit action
                        if (_formKey.currentState!.validate()) {
                          log('login success');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade100.withOpacity(.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.blue,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "or",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/google_icon.svg',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/linkedin_icon.svg',
                            width: 30,
                            color: const Color(0xff0073B1),
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/facebook_icon.svg',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/instagram_icon.svg',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/whatsapp_icon.svg',
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Business User?",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          "Don't have an Account",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Login Here",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                            )),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                            )),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By continuing, you agree to ',
                          style: const TextStyle(color: Colors.grey, fontSize: 12), // Default text style
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Promilo\'s',
                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Terms of Use click
                                  print('Terms of Use clicked');
                                },
                            ),
                            TextSpan(
                              text: '\nTerms of Use',
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Terms of Use click
                                  print('Terms of Use clicked');
                                },
                            ),
                            const TextSpan(
                              text: ' & ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle Privacy Policy click
                                  print('Privacy Policy clicked');
                                },
                            ),
                            const TextSpan(
                              text: '.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String s) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    bool isValidEmail(String email) {
      return emailRegex.hasMatch(email);
    }

    return false;
  }
}
