import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:labwork3/screens/home.dart';
import 'package:labwork3/screens/register.dart';

class LoginLabwork extends StatefulWidget {
  LoginLabwork({super.key});

  @override
  State<LoginLabwork> createState() => _LoginLabworkState();
}

class _LoginLabworkState extends State<LoginLabwork> {
  final formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  void passVisibility() {
    isPasswordVisible = !isPasswordVisible;
    setState(() {});
  }

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => HomeLabwork(),
        ),
      );
    }).catchError((error) {
      EasyLoading.showError('Invalid login credentials');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              const Gap(10),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "* Email is required";
                        }
                        if (!EmailValidator.validate(value)) {
                          return "invalid email";
                        }
                      },
                    ),
                    const Gap(10),
                    TextFormField(
                      obscureText: isPasswordVisible ? false : true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter password',
                        suffixIcon: IconButton(
                          onPressed: passVisibility,
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "* required field";
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => RegisterLabwork(),
                        ),
                      );
                    },
                    child: const Text("Sign up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
