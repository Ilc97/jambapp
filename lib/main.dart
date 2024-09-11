import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/ui/widgets/startPage.dart';

void main() {
  // Set the preferred orientation to portrait up only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyGameApp());
  });
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
