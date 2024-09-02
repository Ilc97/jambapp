import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/core/constants/textControllers.dart';
import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/data/repository/gameStorage.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Zgodovina rezultatov'),
      backgroundColor: primaryColor, // Custom AppBar color
    ),
    backgroundColor: Colors.grey[200], // Custom background color
    body: FutureBuilder<List<GameResult>>(
      future: getAllGameResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          List<GameResult> results = snapshot.data!;

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              GameResult result = results[index];
              String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(result.date);

              return Column(
                children: [
                  ListTile(
                    title: Text(result.name),
                    subtitle: Text(formattedDate),
                    trailing: Text("Rezultat: ${result.result}", style: const TextStyle(fontSize: 16.0)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TableResultPage(result: result),
                        ),
                      );
                    },
                  ),
                  const Divider(), // Line between items
                ],
              );
            },
          );
        }
      },
    ),
  );
}

}

class TableResultPage extends StatelessWidget {
  final GameResult result;
  
  const TableResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.name),
        backgroundColor: primaryColor, // Same custom AppBar color
      ),
      backgroundColor: Colors.grey[200], // Same custom background color
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bgImage, // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Table(
              defaultColumnWidth: FixedColumnWidth(38.0),
              children: result.tableData.map((row) {
                return TableRow(
                  children: row.map((cell) {
                    return TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(1.1),
                        child: _buildCellWidget(cell),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _buildCellWidget(CellData cellData) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 38.0,
        height: 33.0,
        decoration: BoxDecoration(
          color: cellData.color,
          borderRadius: BorderRadius.circular(6.0), // Adjust the border radius here
          
        ),
      child:  _buildText(cellData.name, cellData.colorOfText, cellData.controller, cellData.imagePath),
    ));
  }

  
  Widget _buildText(String name, Color barvaPisave,TextEditingController controller, String imagePath) {
    
    if(name!=""){
      if(imagePath==""){
        return Center(
          child: Text(controller.text,
          style: TextStyle(
              fontSize: customFontSize, // Set the desired font size here
              fontFamily: customFont,
              fontWeight: FontWeight.w700,
              color: barvaPisave,
          ),
          ),
        );
      }else{
        return Center(
          child: Image.asset(
              imagePath,
              fit: BoxFit.cover
          ),
        );
      }
    }else{
      return Center(
        child: Text(controller.text,
        style: TextStyle(
            fontSize: customFontSize, // Set the desired font size here
            fontFamily: customFont,
            fontWeight: FontWeight.w700,
            color: barvaPisave,
        ),
        ),
      );
    }
    
  }

}
