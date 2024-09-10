import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart'; // Assuming this contains your color constants
import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/data/repository/gameStorage.dart';
import 'package:jambapp/ui/widgets/aboutPage.dart';
import 'package:jambapp/ui/widgets/gamePage.dart';
import 'package:jambapp/ui/widgets/resultsPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'JAMB',
          style: TextStyle(
            fontFamily: "MyCustomFont",
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
      ),
      backgroundColor: sumColor,
      body: Center(
        // Wrap the body content with Center
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            // App Logo at the top
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Image.asset(
                'assets/images/app_logo.png', // Replace with your logo path
                width: 100,
                height: 100,
              ),
            ),
            // Custom Button: New Game
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: rowSumColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'IGRA',
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              onPressed: () async {
                GameResult? partialResult = await getPartialGameResult();
                if (partialResult == null) {
                  _showNewGameDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        id: partialResult.id,
                        gameName: partialResult.name,
                        tableData: partialResult.tableData,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20), // Space between buttons
            // Custom Button: Results Page
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: rowSumColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'ZGODOVINA',
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultsPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: rowSumColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'O APLIKACIJI',
                style: TextStyle(
                  fontFamily: "MyCustomFont",
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNewGameDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: 'listek');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: sumColor,
          title: const Text('Nova igra!'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Vnesite ime igre:',
            ),
            maxLength: 12,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Preklici',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Igraj',
                style: TextStyle(
                  color: textColor,
                ),
              ),
              onPressed: () async {
                final String gameName = nameController.text;
                int id = await getNextGameResultId();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                        id: id, gameName: gameName, tableData: const []),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
