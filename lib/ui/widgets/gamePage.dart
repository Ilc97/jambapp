
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/cellConditions.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/core/constants/textControllers.dart';
import 'package:jambapp/data/models/cellData.dart';

import 'package:jambapp/data/repository/gameStorage.dart';
import 'package:jambapp/data/testing/fillTable.dart';
import 'package:jambapp/ui/viewmodels/tableBuild.dart';
import 'package:screenshot/screenshot.dart';

class GamePage extends StatefulWidget {

  int id;
  final String gameName;
  List<List<CellData>> tableData;
  List<bool> cellConditions;
  List<bool> cellConditionsZeroValues;
  Color sum1DownColor;
  Color sum1UpColor;
  Color sum1UpDownColor;
  Color sum1PredColor;

  GamePage({
    super.key, 
    required this.id, 
    required this.gameName, 
    required this.tableData, 
    required this.cellConditions, 
    required this.cellConditionsZeroValues, 
    required this.sum1DownColor, 
    required this.sum1UpColor, 
    required this.sum1UpDownColor, 
    required this.sum1PredColor
  });

  @override
  GamePageState createState() => GamePageState();
}


class GamePageState extends State<GamePage> with WidgetsBindingObserver{
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  TableBuild tableBuild = TableBuild();
  
  @override
  void dispose() {
    super.dispose();
  }

  bool tableFinished = false;
  
  @override
  Widget build(BuildContext context) {
    if(widget.tableData.isEmpty){
      widget.sum1DownColor = sumColor;
      widget.sum1UpColor = sumColor;
      widget.sum1UpDownColor = sumColor;
      widget.sum1PredColor = sumColor;
      widget.cellConditions = List.filled(120, false);
      widget.cellConditionsZeroValues = List.filled(120, false);
      widget.tableData = tableBuild.buildTable(widget.tableData, widget.cellConditions, widget.cellConditionsZeroValues, widget.sum1DownColor, widget.sum1UpColor, widget.sum1UpDownColor, widget.sum1PredColor);    
    }
     // Show dialog if the table is finished
  if (tableFinished) {
    Future.delayed(Duration.zero, () => _showTableFinishedDialog(context));
  }
  
    return WillPopScope(
  onWillPop: () async {

    if(tableFinished){
      return true;
    }

    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Potrditev', style: TextStyle(
          fontFamily: "MyCustomFont",
          fontWeight: FontWeight.w900,
        ),),
          content: const Text('Ali zelite shraniti igro?', style: TextStyle(
          fontFamily: "MyCustomFont",
          fontWeight: FontWeight.w900,
        ),),
          actions: [
            TextButton(
              child: const Text('Preklici', style: TextStyle(
                fontFamily: "MyCustomFont",
                fontWeight: FontWeight.w900,
              ),),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false to indicate cancellation
              },
            ),
            TextButton(
              child: const Text('Zavrzi', style: TextStyle(
                fontFamily: "MyCustomFont",
                fontWeight: FontWeight.w900,
              ),),
              onPressed: () {
                removePartialGame();
                Navigator.of(context).pop(true); // Return false to indicate cancellation
              },
            ),
            TextButton(
              child: const Text('Shrani', style: TextStyle(
          fontFamily: "MyCustomFont",
          fontWeight: FontWeight.w900,
        ),),
              onPressed: () {
                savePartialGameResult(widget.id, widget.gameName, int.tryParse(totalScore.text) ?? 0, widget.tableData, widget.cellConditions, widget.cellConditionsZeroValues, widget.sum1DownColor, widget.sum1UpColor, widget.sum1UpDownColor, widget.sum1PredColor);
                Navigator.of(context).pop(true); // Return true to indicate confirmation
              },
            ),
          ],
        );
      },
    );

    return confirm; // If confirm is null, default to false
  },
  
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.gameName,
          style: TextStyle(
            fontFamily: customFont,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.task_alt, 
              color: Color.fromARGB(255, 29, 29, 29), 
            ),
            onPressed: fillTable, 
          ),
        ],
      ),
      backgroundColor: appBarBG,
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
              children: widget.tableData.map((row) {
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
    ),
);

  

  }

  void _showTableFinishedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Čestitke! Končali ste igro!',
          style: TextStyle(
            fontFamily: customFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Text(
          'Rezultat: ' + totalScore.text + "\n \n Igra se je shranila pod zgodovino rezultatov.",
          style: TextStyle(
            fontFamily: customFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        
        actions: [
          TextButton(
            child: Text(
              'Nadaljuj',
              style: TextStyle(
                fontFamily: customFont,
                fontWeight: FontWeight.w900,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
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
      child: cellData.isInputField ? _buildInputField(cellData.index, cellData.name, cellData.colorOfText, cellData.controller, cellData.color, cellData.allowedScore) : _buildText(cellData.name, cellData.colorOfText, cellData.controller, cellData.imagePath),
    ));
  }

  Widget _buildInputField(int index, String name, Color customTextColor, TextEditingController controller, Color cellBGColor, final allowedScores) {
    
      //Update the sums in the build method with random text values in each calculation part.
      if((index==8) ||(index==51) || (index==70)){
        _updateSumCell(index, cellBGColor, allowedScores, controller);
      }


      final downList = <TextEditingController>[val1DownController, val2DownController, val3DownController, val4DownController, val5DownController, val6DownController, maxDownController, minDownController, pairsDownController, straightDownController, fullDownController, pokerDownController, yahtzeeDownController];
      final upList = <TextEditingController>[val1UpController, val2UpController, val3UpController, val4UpController, val5UpController, val6UpController, maxUpController, minUpController, pairsUpController, straightUpController, fullUpController, pokerUpController, yahtzeeUpController];
      final reversedUpList = upList.reversed.toList();
      bool enableInput = true;

      //Check for down
      int indexOfControllerDol = downList.indexOf(controller);
      if (indexOfControllerDol != -1) {
        //If it is in the array
        if(indexOfControllerDol>0){
          if(downList[indexOfControllerDol-1].text == ""){
            enableInput = false;
          }
        }
      }

      int indexOfControllerUp = reversedUpList.indexOf(controller);
      if (indexOfControllerUp != -1) {
        //If it is in the array
        if(indexOfControllerUp>0){
          if(reversedUpList[indexOfControllerUp-1].text == ""){
            enableInput = false;
          }
        }
      }

        
        return Center(
        child: TextField(
          enabled: enableInput,
          controller: controller,
          maxLength: 2,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            _updateSumCell(index, cellBGColor, allowedScores, controller);
          },
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            isCollapsed: true,
          ),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: customFontSize,
            fontFamily: customFont,
            fontWeight: FontWeight.w700,
            color: customTextColor,
          ),
    ));
  }

  Widget _buildText(String name, Color barvaPisave,TextEditingController controller, String imagePath) {
    
    if(name!=""){
      if(imagePath==""){
        return Center(
          child: Text(name,
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

  
  void _updateSumCell(int index, Color barvaOzadja, final pravilo, TextEditingController  controller) {

    
    //Checking if there are changes in the 1-6 values
    if(index>=7 && index < 43){
        _update1to6values();
    }
    

    //Checking if there are changes in the max/min values
    if(index>=49 && index<61){
      _updateMaxMinValues();
    }

    //Checking if there are changes in the special games values
    if(index>=67 && index<97){
      _updateSpecialGamesValues();
    }
    
    
    _updateTotalSum();
    
   
    //Check if controller text has the allowed score
    setState(() {
      int controllerValue = int.tryParse(controller.text) ?? -1;
      if(pravilo.length > 0 && controllerValue >= 0){
        if(pravilo.contains(controllerValue)){
          widget.cellConditions[index] = false;
          widget.tableData[index~/numOfColumns][index-(numOfColumns*(index~/numOfColumns))-1].color = cellBGColor;
          tableFinished = tableBuild.checkIfTableFinished();
          if(tableFinished){
            saveNewGameResult(widget.id, widget.gameName, tableFinished,   int.tryParse(totalScore.text) ?? 0, widget.tableData, widget.cellConditions, widget.cellConditionsZeroValues, widget.sum1DownColor, widget.sum1UpColor, widget.sum1UpDownColor, widget.sum1PredColor);
          }
        }else{
          widget.cellConditions[index] = true;
          widget.tableData[index~/numOfColumns][index-(numOfColumns*(index~/numOfColumns))-1].color = errorColor;
        }

        if(controllerValue==0 && pravilo.contains(controllerValue) && controller.text!=""){
        widget.tableData[index~/numOfColumns][index-(numOfColumns*(index~/numOfColumns))-1].color  = zeroValueColor;
        tableFinished = tableBuild.checkIfTableFinished();
        if(tableFinished){
          saveNewGameResult(widget.id, widget.gameName, tableFinished, int.tryParse(totalScore.text) ?? 0, widget.tableData, widget.cellConditions, widget.cellConditionsZeroValues, widget.sum1DownColor, widget.sum1UpColor, widget.sum1UpDownColor, widget.sum1PredColor);
        }
      }
      }
      else{
        widget.tableData[index~/numOfColumns][index-(numOfColumns*(index~/numOfColumns))-1].color = cellBGColor;
      }
    
    }
    );
  }

  void _update1to6values(){
    //Summing down column
    final int down1 = int.tryParse(val1DownController.text) ?? 0;
    final int down2 = int.tryParse(val2DownController.text) ?? 0;
    final int down3 = int.tryParse(val3DownController.text) ?? 0;
    final int down4 = int.tryParse(val4DownController.text) ?? 0;
    final int down5 = int.tryParse(val5DownController.text) ?? 0;
    final int down6 = int.tryParse(val6DownController.text) ?? 0;
    int sumDown = down1 + down2 + down3 + down4 + down5 + down6;
    if(sumDown>=60){
      sumDown += 30;
      setState(() {
        widget.sum1DownColor = sumCorrectColor;
      });
    }else{
      setState(() {
        widget.sum1DownColor = sumColor;
      });
    }

    //Summing up column
    final int up1 = int.tryParse(val1UpController.text) ?? 0;
    final int up2 = int.tryParse(val2UpController.text) ?? 0;
    final int up3 = int.tryParse(val3UpController.text) ?? 0;
    final int up4 = int.tryParse(val4UpController.text) ?? 0;
    final int up5 = int.tryParse(val5UpController.text) ?? 0;
    final int up6 = int.tryParse(val6UpController.text) ?? 0;
    int sumUp = up1 + up2 + up3 + up4 + up5 + up6;
  
    if(sumUp>=60){
      sumUp += 30;
      setState(() {
        widget.sum1UpColor = sumCorrectColor;
      });
    }else{
      setState(() {
        widget.sum1UpColor = sumColor;
      });
    }


    //Summing up-down column
    final int upDown1 = int.tryParse(val1UpDownController.text) ?? 0;
    final int upDown2 = int.tryParse(val2UpDownController.text) ?? 0;
    final int upDown3 = int.tryParse(val3UpDownController.text) ?? 0;
    final int upDown4 = int.tryParse(val4UpDownController.text) ?? 0;
    final int upDown5 = int.tryParse(val5UpDownController.text) ?? 0;
    final int upDown6 = int.tryParse(val6UpDownController.text) ?? 0;
    int sumUpDown = upDown1 + upDown2 + upDown3 + upDown4 + upDown5 + upDown6;

    if(sumUpDown>=60){
      sumUpDown += 30;
      setState(() {
        widget.sum1UpDownColor = sumCorrectColor;
      });
    }else{
      setState(() {
        widget.sum1UpDownColor = sumColor;
      });
    }

    final int pred1 = int.tryParse(val1PredController.text) ?? 0;
    final int pred2 = int.tryParse(val2PredController.text) ?? 0;
    final int pred3 = int.tryParse(val3PredController.text) ?? 0;
    final int pred4 = int.tryParse(val4PredController.text) ?? 0;
    final int pred5 = int.tryParse(val5PredController.text) ?? 0;
    final int pred6 = int.tryParse(val6PredController.text) ?? 0;
    int sumPred = pred1 + pred2 + pred3 + pred4 + pred5 + pred6;

    if(sumPred>=60){
      sumPred += 30;
      setState(() {
        widget.sum1PredColor = sumCorrectColor;
      });
    }else{
      setState(() {
        widget.sum1PredColor = sumColor;
      });
    }

    int sumOver60 = sumDown + sumUp + sumUpDown + sumPred;

    setState(() {
      print("sumDown: " + sumDown.toString());
      sum1downController.text = sumDown.toString();
      sum1upController.text = sumUp.toString();
      sum1upDownController.text = sumUpDown.toString();
      sum1predController.text = sumPred.toString();
      sum1TotalController.text = sumOver60.toString();
    });
  }


  void _updateMaxMinValues(){
  
    //MAX
    int maxDown = int.tryParse(maxDownController.text) ?? 0;
    int maxUp = int.tryParse(maxUpController.text) ?? 0;
    int maxUpDown = int.tryParse(maxUpDownController.text) ?? 0;
    int maxPred = int.tryParse(maxPredController.text) ?? 0;
    
    //MIN
    int minDown = int.tryParse(minDownController.text) ?? 0;
    int minUp = int.tryParse(minUpController.text) ?? 0;
    int minUpDown = int.tryParse(minUpDownController.text) ?? 0;
    int minPred = int.tryParse(minPredController.text) ?? 0;
    
    //SUM 2 CALCULATE
    int diffDown = 0;
    int diffUp = 0;
    int diffUpDown = 0;
    int diffPred = 0;
    
    int down1 = int.tryParse(val1DownController.text) ?? 0;
    int up1 = int.tryParse(val1UpController.text) ?? 0;
    int upDown1 = int.tryParse(val1UpDownController.text) ?? 0;
    int pred1 = int.tryParse(val1PredController.text) ?? 0;

    if(maxDown > 0 && minDown > 0){
      diffDown = (maxDown - minDown) * down1;
    }

    if(maxUp > 0 && minUp > 0){
      diffUp = (maxUp - minUp) * up1;
    }

    if(maxUpDown > 0 && minUpDown > 0){
      diffUpDown = (maxUpDown - minUpDown) * upDown1;
    }

    if(maxPred > 0 && minPred > 0){
      diffPred = (maxPred - minPred) * pred1;
    }

    setState(() {
      sum2downController.text = diffDown.toString();
      sum2upController.text = diffUp.toString();
      sum2upDownController.text = diffUpDown.toString();
      sum2predController.text = diffPred.toString();
      sum2TotalController.text = (diffDown + diffUp + diffUpDown + diffPred).toString();
    });

  }

  _updateSpecialGamesValues(){
    //Pairs
    int pairsDownSum = int.tryParse(pairsDownController.text) ?? 0;
    int pairsUpSum = int.tryParse(pairsUpController.text) ?? 0;
    int pairsUpDownSum = int.tryParse(pairsUpDownController.text) ?? 0;
    int pairsPredSum = int.tryParse(pairsPredController.text) ?? 0;

    //Straight
    int straightDownSum = int.tryParse(straightDownController.text) ?? 0;
    int straightUpSum = int.tryParse(straightUpController.text) ?? 0;
    int straightUpDownSum = int.tryParse(straightUpDownController.text) ?? 0;
    int straightPredSum = int.tryParse(straightPredController.text) ?? 0;

    //Full
    int fullDownSum = int.tryParse(fullDownController.text) ?? 0;
    int fullUpSum = int.tryParse(fullUpController.text) ?? 0;
    int fullUpDownSum = int.tryParse(fullUpDownController.text) ?? 0;
    int fullPredSum = int.tryParse(fullPredController.text) ?? 0;

    //Poker
    int pokerDownSUm = int.tryParse(pokerDownController.text) ?? 0;
    int pokerUpSum = int.tryParse(pokerUpController.text) ?? 0;
    int pokerUpDownSum = int.tryParse(pokerUpDownController.text) ?? 0;
    int pokerPredSum = int.tryParse(pokerPredController.text) ?? 0;

    //Yahtzee
    int yahtzeeDownSum = int.tryParse(yahtzeeDownController.text) ?? 0;
    int yahtzeeUpSum = int.tryParse(yahtzeeUpController.text) ?? 0;
    int yahtzeeUpDownSum = int.tryParse(yahtzeeUpDownController.text) ?? 0;
    int yahtzeePredSum = int.tryParse(yahtzeePredController.text) ?? 0;


    //SUM 3 
    int downSum3 = pairsDownSum + straightDownSum + fullDownSum + pokerDownSUm + yahtzeeDownSum;
    int upSum3 = pairsUpSum + straightUpSum + fullUpSum + pokerUpSum + yahtzeeUpSum;
    int upDownSum3 = pairsUpDownSum + straightUpDownSum + fullUpDownSum + pokerUpDownSum + yahtzeeUpDownSum;
    int predSum3 = pairsPredSum + straightPredSum + fullPredSum + pokerPredSum + yahtzeePredSum;
    int sum3 = downSum3 + upSum3  + upDownSum3 + predSum3;
    sum3downController.text = downSum3.toString();
    sum3upController.text = upSum3.toString();
    sum3upDownController.text = upDownSum3.toString();
    sum3predController.text = predSum3.toString();
    sum3TotalController.text = sum3.toString();
  }

  void _updateTotalSum(){
    int sum1 = int.tryParse(sum1TotalController.text)?? 0;
    int sum2 = int.tryParse(sum2TotalController.text)?? 0;
    int sum3 = int.tryParse(sum3TotalController.text)?? 0;
    int totalScoreValue = sum1 + sum2 + sum3;
    
    setState(() {
      totalScore.text = totalScoreValue.toString();
    });
  }



  //If the app goes to background, save the game
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
     savePartialGameResult(widget.id, widget.gameName, int.tryParse(totalScore.text) ?? 0, widget.tableData, widget.cellConditions, widget.cellConditionsZeroValues, widget.sum1DownColor, widget.sum1UpColor, widget.sum1UpDownColor, widget.sum1PredColor);
                
    }
  }

}

