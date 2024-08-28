import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/allowedScores.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/core/constants/textControllers.dart';
import 'package:jambapp/data/models/cellData.dart';

class TableBuild extends ChangeNotifier {
  //Main function for building the game table
  List<List<CellData>> buildTable(List<List<CellData>> tableData, List<bool> cellConditions, List<bool> cellConditionsZeroValues, Color sum1DownColor, Color sum1UpColor, Color sum1UpDownColor, Color sum1PredColor) {
    
    //First row cells data
    tableData = [
      [
        CellData(index: 1,name: '',   color: backgroundColorOfImage,  isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 2,name: 'D', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/downarrow.png"),
        CellData(index: 3,name: 'U', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/uparrow.png"),
        CellData(index: 4,name: 'UD', color: cellConditions[14] ? errorColor : cellBGColor, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/updownarrow.png"),
        CellData(index: 5,name: 'P', color: cellConditions[14] ? errorColor : cellBGColor, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/prediction.png"),
        CellData(index: 6,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
    ]];

    //Cell data for 1-6 values.
    int indexCount = 7;
    for(int i=0;i<6;i++){
      List<CellData> tableRow = [];
      for(int j=0;j<6;j++){
        tableRow.add(CellData(index: indexCount, name: (j==5) ? "" : indexCount.toString(), color: (j==0 || j==5) ? backgroundColorOfImage : (cellConditions[indexCount] ? errorColor : cellBGColor), isInputField: (j==0 || j==5) ? false : true, allowedScore: (j==0 || j==5) ? emptyAllowedScore : listOfAllowedScores[i], controller: (j==0 || j==5) ? emptyTextController : listOfTextControllers[i][j], imagePath: (j==0) ? seqOfRowImages[i] : ""));
        indexCount++;
      }
      tableData.add(tableRow);
    }
      
      tableData.add([
        CellData(index: 43,name: '>60',   color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/sum.png"),
        CellData(index: 44,name: '', color: sum1DownColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum1downController, imagePath: ""),
        CellData(index: 45,name: '', color: sum1UpColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum1upController, imagePath: ""),
        CellData(index: 46,name: '', color: sum1UpDownColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum1upDownController, imagePath: ""),
        CellData(index: 47,name: '', color: sum1PredColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum1predController, imagePath: ""),
        CellData(index: 48,name: '', color: rowSumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum1TotalController, imagePath: ""),
      ]);

      tableData.add([
        CellData(index: 49,name: 'MAX',   color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/max.png"),
        CellData(index: 50,name: 'max_dol', color: cellConditions[50] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMax, controller: maxDownController, imagePath: ""),
        CellData(index: 51,name: 'max_gor', color: cellConditions[51] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMax, controller: maxUpController, imagePath: ""),
        CellData(index: 52,name: 'max_gd', color: cellConditions[52] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMax, controller: maxUpDownController, imagePath: ""),
        CellData(index: 53,name: 'max_n', color: cellConditions[53] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMax, controller: maxPredController, imagePath: ""),
        CellData(index: 54,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
      ]);
      tableData.add([
        CellData(index: 55,name: 'MIN',   color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/min.png"),
        CellData(index: 56,name: 'min_dol', color: cellConditions[56] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMin, controller: minDownController, imagePath: ""),
        CellData(index: 57,name: 'min_gor', color: cellConditions[57] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMin, controller: minUpController, imagePath: ""),
        CellData(index: 58,name: 'min_gd', color: cellConditions[58] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMin, controller: minUpDownController, imagePath: ""),
        CellData(index: 59,name: 'min_n', color: cellConditions[59] ? errorColor : cellBGColor, isInputField: true, allowedScore: scoreMin, controller: minPredController, imagePath: ""),
        CellData(index: 60,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
      ]);
      tableData.add([
        CellData(index: 61,name: 'R',   color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/sum.png"),
        CellData(index: 62,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum2downController, imagePath: ""),
        CellData(index: 63,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum2upController, imagePath: ""),
        CellData(index: 64,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum2upDownController, imagePath: ""),
        CellData(index: 65,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum2predController, imagePath: ""),
        CellData(index: 66,name: '', color: rowSumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum2TotalController, imagePath: ""),
      ]);

      //Special games
      indexCount = 67;
      for(int i=10;i<15;i++){
        List<CellData> tableRow = [];
        for(int j=0;j<6;j++){
          tableRow.add(CellData(index: indexCount, name: (j==5) ? "" : indexCount.toString(), color: (j==0 || j==5) ? backgroundColorOfImage : (cellConditions[indexCount] ? errorColor : cellConditionsZeroValues[indexCount] ? zeroValueColor: cellBGColor), isInputField: (j==0 || j==5) ? false : true, allowedScore: (j==0 || j==5) ? emptyAllowedScore : listOfAllowedScores[i], controller: (j==0 || j==5) ? emptyTextController : listOfTextControllers[i][j], imagePath: (j==0) ? seqOfRowImages[i] : ""));
          indexCount++;
        }
        tableData.add(tableRow);
      }
      
      //Last two rows
      tableData.add([
        CellData(index: 97,name: 'SUM',   color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: "assets/images/sum.png"),
        CellData(index: 98,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum3downController, imagePath: ""),
        CellData(index: 99,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum3upController, imagePath: ""),
        CellData(index: 100,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum3upDownController, imagePath: ""),
        CellData(index: 101,name: '', color: sumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum3predController, imagePath: ""),
        CellData(index: 102,name: '', color: rowSumColor, isInputField: false, allowedScore: emptyAllowedScore, controller: sum3TotalController, imagePath: ""),
      ]);
      tableData.add([
        CellData(index: 103,name: '',  color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 104,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 105,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 106,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 107,name: '', color: backgroundColorOfImage, isInputField: false, allowedScore: emptyAllowedScore, controller: emptyTextController, imagePath: ""),
        CellData(index: 108,name: '', color: totalScoreColor, isInputField: false, allowedScore: emptyAllowedScore, controller: totalScore, imagePath: ""),
      ]);

      // Add more rows here...
    return tableData;
  }
}