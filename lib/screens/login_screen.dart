import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_development_task/constants/string_constants.dart';
import 'package:flutter_development_task/global_fun.dart';
import 'package:flutter_development_task/screens/meetup_screen.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  bool isObscureText = true;
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
          StringConstants.promilo,
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
                      StringConstants.greeting,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    const Text(StringConstants.signIn),
                    const SizedBox(height: 4),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          RegExp mobileNoRegex = RegExp(r'^\d{10}');
                          if (mobileNoRegex.hasMatch(value)) {
                            log('mobile number entered...');
                            return StringConstants.mobileNoEmailValidation;
                          } else if (EmailValidator.validate(value) && value.contains(StringConstants.emailId)) {
                            return null;
                          } else {
                            return StringConstants.wrongEmailValidation;
                          }
                        }
                        return StringConstants.wrongEmailValidation;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: StringConstants.emailHint,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          ToastMessage.showToastMessage('${StringConstants.singInWithOtp}!!');
                        },
                        child: const Text(
                          StringConstants.singInWithOtp,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(StringConstants.passwordText),
                    const SizedBox(height: 4),
                    TextFormField(
                      validator: (value) {
                        if (value != null && value.isNotEmpty && value.contains(StringConstants.password)) {
                          return null;
                        }
                        return StringConstants.wrongPasswordValidation;
                      },
                      controller: passwordController,
                      obscureText: isObscureText,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: StringConstants.passwordHint,
                        suffixIcon: IconButton(
                          icon: Icon(isObscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                          onPressed: () {
                            log('visibility clicked...');
                            isObscureText = !isObscureText;
                            setState(() {});
                          },
                        ),
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
                            Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  isChecked = value!;
                                  setState(() {});
                                }),
                            const Text(StringConstants.rememberMe),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            ToastMessage.showToastMessage('${StringConstants.forgetPassword}!!');
                          },
                          child: const Text(
                            StringConstants.forgetPassword,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ToastMessage.showToastMessage('${StringConstants.loginSuccess}!!');
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MeetupScreen();
                            },
                          ));
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
                        StringConstants.submit,
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
                            StringConstants.googleIcon,
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            StringConstants.linkedInIcon,
                            width: 30,
                            color: const Color(0xff0073B1),
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            StringConstants.facebookIcon,
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            StringConstants.instagramIcon,
                            width: 30,
                            height: 30,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            StringConstants.whatsappIcon,
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
                          StringConstants.businessUser,
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          StringConstants.dontHaveAccount,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              ToastMessage.showToastMessage('${StringConstants.loginHere}!!');
                            },
                            child: const Text(
                              StringConstants.loginHere,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                            )),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              ToastMessage.showToastMessage('${StringConstants.signUp}!!');
                            },
                            child: const Text(
                              StringConstants.signUp,
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
                          text: StringConstants.agree,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          children: <TextSpan>[
                            TextSpan(
                              text: '\n${StringConstants.terms}',
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ToastMessage.showToastMessage('${StringConstants.terms}!!');
                                },
                            ),
                            const TextSpan(
                              text: ' & ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextSpan(
                              text: StringConstants.privacy,
                              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ToastMessage.showToastMessage('${StringConstants.privacy}!!');
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
