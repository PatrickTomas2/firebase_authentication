import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:labwork3/firebase_options.dart';
import 'package:labwork3/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(PjstLabwork3());
}

class PjstLabwork3 extends StatelessWidget {
  const PjstLabwork3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginLabwork(),
      builder: EasyLoading.init(),
    );
  }
}
