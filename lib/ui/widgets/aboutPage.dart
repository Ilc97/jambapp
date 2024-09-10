import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'O APLIKACIJI',
          style: TextStyle(
            fontFamily: "MyCustomFont",
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      backgroundColor: sumColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Avtor: Matic Ilc',
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'April 2023',
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: rowSumColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 30.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'NAZAJ',
                  style: TextStyle(
                    fontFamily: "MyCustomFont",
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
