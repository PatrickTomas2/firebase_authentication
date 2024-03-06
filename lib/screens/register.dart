import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:labwork3/screens/login.dart';
import 'package:quickalert/quickalert.dart';

class RegisterLabwork extends StatefulWidget {
  RegisterLabwork({super.key});

  @override
  State<RegisterLabwork> createState() => _RegisterLabworkState();
}

class _RegisterLabworkState extends State<RegisterLabwork> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void passVisibility() {
    isPasswordVisible = !isPasswordVisible;
    setState(() {});
  }

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: 'Are you sure?',
        confirmBtnText: 'YES',
        cancelBtnText: 'No',
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          onRegisterClient();
        });
  }

  void onRegisterClient() async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Registering your account',
    );

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Navigator.of(context).pop();
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
                  'REGISTER',
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
                onPressed: register,
                child: const Text('Sign up'),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => LoginLabwork(),
                        ),
                      );
                    },
                    child: const Text("Login"),
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
