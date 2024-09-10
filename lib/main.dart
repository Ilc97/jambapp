import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/ui/widgets/startPage.dart';

void main() {
  runApp(const MyGameApp());
}

class MyGameApp extends StatelessWidget {
  const MyGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jamb',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: const StartPage(),
    );
  }
}
