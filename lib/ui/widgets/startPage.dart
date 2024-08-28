
import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/data/repository/gameStorage.dart';
import 'package:jambapp/ui/widgets/gamePage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JAMB',
          style: TextStyle(
            fontFamily: "MyCustomFont",
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: backgroundColor, // Replace with your background color
      body: Center(
        child: ElevatedButton(
          child: const Text(
            'IGRA',
            style: TextStyle(
              fontFamily: "MyCustomFont",
              fontWeight: FontWeight.w900,
            ),
          ),
          onPressed: () async {
            GameResult? partialResult = await getPartialGameResult();
            if(partialResult==null){
              _showNewGameDialog(context);
            }
            else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(gameName: partialResult.name, tableData: partialResult.tableData,),
                  ),
                );
            }
            
          },
        ),
      ),
    );
  }

  void _showNewGameDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: 'listek');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              child: const Text('Preklici'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Igraj'),
              onPressed: () {
                // Use the value from the TextEditingController
                final String gameName = nameController.text;
                
                // Navigate to the GamePage, passing the playerName if needed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(gameName: gameName, tableData: const [],),
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