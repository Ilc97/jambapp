import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/allowedScores.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/data/models/imageCellData.dart';
import 'package:jambapp/data/models/sumCellData.dart';
import 'package:jambapp/data/models/sumMaxMinCellData.dart';
import 'package:jambapp/data/models/totalRowSumCellData.dart';
import 'package:jambapp/data/models/totalSumCellData.dart';

class TableBuild extends ChangeNotifier {
  TotalSumCellData totalSum =
      TotalSumCellData(controller: TextEditingController(text: '0'));
  //Initialize the value one, max and min values, to add later add it to the max/min sum.
  late CellData value1down;
  late CellData value1up;
  late CellData value1upDown;
  late CellData value1pred;

  late CellData maxDown;
  late CellData maxUp;
  late CellData maxUpDown;
  late CellData maxPred;

  late CellData minDown;
  late CellData minUp;
  late CellData minUpDown;
  late CellData minPred;
  //Main function for building the game table
  List<List<dynamic>> buildTable(List<List<dynamic>> tableData) {
    //Initialize all the row SUM cells.
    TotalRowSumCellData sum1total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);
    TotalRowSumCellData sum2total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);
    TotalRowSumCellData sum3total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);

    //Initialize all the sum cells
    //Starting with first sum
    SumCellData sum1down = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1up = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1upDown = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1pred = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);

    //third sum
    SumCellData sum3down = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3up = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3upDown = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3pred = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);

    //First row cells data (only images)
    tableData = [
      [
        null,
        ImageCellData(imagePath: 'assets/images/downarrow.png'),
        ImageCellData(imagePath: 'assets/images/uparrow.png'),
        ImageCellData(imagePath: 'assets/images/updownarrow.png'),
        ImageCellData(imagePath: 'assets/images/prediction.png'),
        null,
      ]
    ];

    //Cell data for 1-6 values.
    int indexCount = 7;
    for (int i = 0; i < 6; i++) {
      List<dynamic> tableRow = [];
      for (int j = 0; j < 6; j++) {
        if (j == 0) {
          tableRow.add(ImageCellData(imagePath: seqOfRowImages[i]));
        } else if (j == 5) {
          tableRow.add(null);
        } else if (i == 0) {
          //if value one values
          if (j == 1) {
            value1down = CellData(
              index: indexCount,
              name: indexCount.toString(),
              color: cellBGColor,
              isInputField: true,
              allowedScore: listOfAllowedScores[i],
              controller: TextEditingController(),
              sumCell: (j == 1)
                  ? sum1down
                  : (j == 2)
                      ? sum1up
                      : (j == 3)
                          ? sum1upDown
                          : sum1pred,
              maxMinCell: false,
            );
            tableRow.add(value1down);
          } else if (j == 2) {
            value1up = CellData(
              index: indexCount,
              name: indexCount.toString(),
              color: cellBGColor,
              isInputField: true,
              allowedScore: listOfAllowedScores[i],
              controller: TextEditingController(),
              sumCell: (j == 1)
                  ? sum1down
                  : (j == 2)
                      ? sum1up
                      : (j == 3)
                          ? sum1upDown
                          : sum1pred,
              maxMinCell: false,
            );
            tableRow.add(value1up);
          } else if (j == 3) {
            value1upDown = CellData(
              index: indexCount,
              name: indexCount.toString(),
              color: cellBGColor,
              isInputField: true,
              allowedScore: listOfAllowedScores[i],
              controller: TextEditingController(),
              sumCell: (j == 1)
                  ? sum1down
                  : (j == 2)
                      ? sum1up
                      : (j == 3)
                          ? sum1upDown
                          : sum1pred,
              maxMinCell: false,
            );
            tableRow.add(value1upDown);
          } else if (j == 4) {
            value1pred = CellData(
              index: indexCount,
              name: indexCount.toString(),
              color: cellBGColor,
              isInputField: true,
              allowedScore: listOfAllowedScores[i],
              controller: TextEditingController(),
              sumCell: (j == 1)
                  ? sum1down
                  : (j == 2)
                      ? sum1up
                      : (j == 3)
                          ? sum1upDown
                          : sum1pred,
              maxMinCell: false,
            );
            tableRow.add(value1pred);
          }
        } else {
          tableRow.add(CellData(
            index: indexCount,
            name: indexCount.toString(),
            color: cellBGColor,
            isInputField: true,
            allowedScore: listOfAllowedScores[i],
            controller: TextEditingController(),
            sumCell: (j == 1)
                ? sum1down
                : (j == 2)
                    ? sum1up
                    : (j == 3)
                        ? sum1upDown
                        : sum1pred,
            maxMinCell: false,
          ));
        }

        indexCount++;
      }
      tableData.add(tableRow);
    }

    //First sum row.
    tableData.add([
      ImageCellData(imagePath: "assets/images/sum.png"),
      sum1down,
      sum1up,
      sum1upDown,
      sum1pred,
      sum1total,
    ]);

    maxDown = CellData(
        index: 50,
        name: 'max_down',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1down,
        maxMinCell: true);
    maxUp = CellData(
        index: 51,
        name: 'max_up',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1up,
        maxMinCell: true);
    maxUpDown = CellData(
        index: 52,
        name: 'max_ud',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1upDown,
        maxMinCell: true);
    maxPred = CellData(
        index: 53,
        name: 'max_p',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1pred,
        maxMinCell: true);

    minDown = CellData(
        index: 56,
        name: 'min_down',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1down,
        maxMinCell: true);
    minUp = CellData(
        index: 57,
        name: 'min_up',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1up,
        maxMinCell: true);
    minUpDown = CellData(
        index: 58,
        name: 'min_ud',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1upDown,
        maxMinCell: true);
    minPred = CellData(
        index: 59,
        name: 'min_p',
        color: cellBGColor,
        isInputField: true,
        allowedScore: scoreMax,
        controller: TextEditingController(),
        sumCell: sum1pred,
        maxMinCell: true);
    //Initialize second row sum
    //second sum
    SumMaxMinCellData sum2down = SumMaxMinCellData(
        controller: TextEditingController(text: "0"),
        totalSum: sum2total,
        oneValue: value1down,
        maxValue: maxDown,
        minValue: minDown);
    SumMaxMinCellData sum2up = SumMaxMinCellData(
        controller: TextEditingController(text: "0"),
        totalSum: sum2total,
        oneValue: value1up,
        maxValue: maxUp,
        minValue: minUp);
    SumMaxMinCellData sum2upDown = SumMaxMinCellData(
        controller: TextEditingController(text: "0"),
        totalSum: sum2total,
        oneValue: value1upDown,
        maxValue: maxUpDown,
        minValue: minUpDown);
    SumMaxMinCellData sum2pred = SumMaxMinCellData(
        controller: TextEditingController(text: "0"),
        totalSum: sum2total,
        oneValue: value1pred,
        maxValue: maxPred,
        minValue: minPred);

    //Max row.
    tableData.add([
      ImageCellData(imagePath: "assets/images/max.png"),
      maxDown,
      maxUp,
      maxUpDown,
      maxPred,
      null,
    ]);

    //Min row.
    tableData.add([
      ImageCellData(imagePath: "assets/images/min.png"),
      minDown,
      minUp,
      minUpDown,
      minPred,
      null,
    ]);

    //Second sum row.
    tableData.add([
      ImageCellData(imagePath: "assets/images/sum.png"),
      sum2down,
      sum2up,
      sum2upDown,
      sum2pred,
      sum2total,
    ]);

    //Special games
    indexCount = 67;
    for (int i = 10; i < 15; i++) {
      List<dynamic> tableRow = [];
      for (int j = 0; j < 6; j++) {
        if (j == 0) {
          tableRow.add(ImageCellData(imagePath: seqOfRowImages[i]));
        } else if (j == 5) {
          tableRow.add(null);
        } else {
          tableRow.add(CellData(
              index: indexCount,
              name: indexCount.toString(),
              color: cellBGColor,
              isInputField: true,
              allowedScore: listOfAllowedScores[i],
              controller: TextEditingController(),
              sumCell: (j == 1)
                  ? sum3down
                  : (j == 2)
                      ? sum3up
                      : (j == 3)
                          ? sum3upDown
                          : sum3pred,
              maxMinCell: false));
          indexCount++;
        }
      }
      tableData.add(tableRow);
    }

    //Third sum row.
    tableData.add([
      ImageCellData(imagePath: "assets/images/sum.png"),
      sum3down,
      sum3up,
      sum3upDown,
      sum3pred,
      sum3total,
    ]);

    //Final row.
    tableData.add([
      null,
      null,
      null,
      null,
      null,
      totalSum,
    ]);

    // Add more rows here...
    return tableData;
  }

  //Gets a stored table result and rebuilds the table
  GameResult rebuildTable(Map<String, dynamic> json, bool inputField) {
    //Initialize all the row SUM cells.
    TotalRowSumCellData sum1total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);
    TotalRowSumCellData sum2total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);
    TotalRowSumCellData sum3total = TotalRowSumCellData(
        controller: TextEditingController(text: '0'), totalSum: totalSum);

    //Initialize the sum cells
    //Starting with first sum
    SumCellData sum1down = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1up = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1upDown = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);
    SumCellData sum1pred = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: true,
        totalSum: sum1total);

    //third sum
    SumCellData sum3down = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3up = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3upDown = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);
    SumCellData sum3pred = SumCellData(
        color: sumColor,
        controller: TextEditingController(text: '0'),
        firstRowSum: false,
        totalSum: sum3total);

    //Initialize the value one, max and min values, to add later add it to the max/min sum.
    CellData value1down = CellData(
        index: 0,
        name: "name",
        color: backgroundColor,
        isInputField: true,
        controller: TextEditingController(),
        allowedScore: [],
        sumCell: sum1down,
        maxMinCell: false);
    CellData value1up = CellData(
        index: 0,
        name: "name",
        color: backgroundColor,
        isInputField: true,
        controller: TextEditingController(),
        allowedScore: [],
        sumCell: sum1down,
        maxMinCell: false);
    CellData value1upDown = CellData(
        index: 0,
        name: "name",
        color: backgroundColor,
        isInputField: true,
        controller: TextEditingController(),
        allowedScore: [],
        sumCell: sum1down,
        maxMinCell: false);
    CellData value1pred = CellData(
        index: 0,
        name: "name",
        color: backgroundColor,
        isInputField: true,
        controller: TextEditingController(),
        allowedScore: [],
        sumCell: sum1down,
        maxMinCell: false);

    late CellData maxDown;
    late CellData maxUp;
    late CellData maxUpDown;
    late CellData maxPred;

    late CellData minDown;
    late CellData minUp;
    late CellData minUpDown;
    late CellData minPred;

    return GameResult(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      finished: json['finished'],
      result: json['result'],

      // Process tableData with row and column counters, returning directly without MapEntry
      tableData: (json['tableData'] as List).asMap().entries.map((rowEntry) {
        int rowIndex = rowEntry.key;
        List row = rowEntry.value;

        return row.asMap().entries.map((colEntry) {
          int colIndex = colEntry.key;
          var cell = colEntry.value;
          switch (cell['type']) {
            case 'CellData':
              // Check if first sum cells
              if (0 < rowIndex && rowIndex < 7) {
                if (rowIndex == 1) {
                  if (colIndex == 1) {
                    value1down =
                        CellData.fromJson(cell, sum1down, inputField, false);
                    return value1down;
                  } else if (colIndex == 2) {
                    value1up =
                        CellData.fromJson(cell, sum1up, inputField, false);
                    return value1up;
                  } else if (colIndex == 3) {
                    value1upDown =
                        CellData.fromJson(cell, sum1upDown, inputField, false);
                    return value1upDown;
                  } else if (colIndex == 4) {
                    value1pred =
                        CellData.fromJson(cell, sum1pred, inputField, false);
                    return value1pred;
                  }
                }

                if (colIndex == 1) {
                  return CellData.fromJson(cell, sum1down, inputField, false);
                } else if (colIndex == 2) {
                  return CellData.fromJson(cell, sum1up, inputField, false);
                } else if (colIndex == 3) {
                  return CellData.fromJson(cell, sum1upDown, inputField, false);
                } else if (colIndex == 4) {
                  return CellData.fromJson(cell, sum1pred, inputField, false);
                }
              }
              // Check if second sum cells
              else if (rowIndex == 8) {
                if (colIndex == 1) {
                  maxDown = CellData.fromJson(cell, sum1down, inputField, true);
                  return maxDown;
                } else if (colIndex == 2) {
                  maxUp = CellData.fromJson(cell, sum1up, inputField, true);
                  return maxUp;
                } else if (colIndex == 3) {
                  maxUpDown =
                      CellData.fromJson(cell, sum1upDown, inputField, true);
                  return maxUpDown;
                } else if (colIndex == 4) {
                  maxPred = CellData.fromJson(cell, sum1pred, inputField, true);
                  return maxPred;
                }
              }
              // Check if second sum cells
              else if (rowIndex == 9) {
                if (colIndex == 1) {
                  minDown = CellData.fromJson(cell, sum1down, inputField, true);
                  return minDown;
                } else if (colIndex == 2) {
                  minUp = CellData.fromJson(cell, sum1up, inputField, true);
                  return minUp;
                } else if (colIndex == 3) {
                  minUpDown =
                      CellData.fromJson(cell, sum1upDown, inputField, true);
                  return minUpDown;
                } else if (colIndex == 4) {
                  minPred = CellData.fromJson(cell, sum1pred, inputField, true);
                  return minPred;
                }
              }
              // Check if third sum cells
              else if (10 < rowIndex && rowIndex < 16) {
                if (colIndex == 1) {
                  return CellData.fromJson(cell, sum3down, inputField, false);
                } else if (colIndex == 2) {
                  return CellData.fromJson(cell, sum3up, inputField, false);
                } else if (colIndex == 3) {
                  return CellData.fromJson(cell, sum3upDown, inputField, false);
                } else if (colIndex == 4) {
                  return CellData.fromJson(cell, sum3pred, inputField, false);
                }
              }
              break;

            case 'ImageCellData':
              return ImageCellData.fromJson(cell);
            case 'SumCellData':
              // Check if first sum cells
              if (rowIndex == 7) {
                if (colIndex == 1) {
                  sum1down.controller.text =
                      SumCellData.fromJson(cell).controller.text;
                  return sum1down;
                } else if (colIndex == 2) {
                  sum1up.controller.text =
                      SumCellData.fromJson(cell).controller.text;
                  return sum1up;
                } else if (colIndex == 3) {
                  sum1upDown.controller.text =
                      SumCellData.fromJson(cell).controller.text;
                  return sum1upDown;
                } else if (colIndex == 4) {
                  sum1pred.controller.text =
                      SumCellData.fromJson(cell).controller.text;
                  return sum1pred;
                }
              }
              // Check if third sum cells
              else if (rowIndex == 16) {
                if (colIndex == 1) {
                  return sum3down;
                } else if (colIndex == 2) {
                  return sum3up;
                } else if (colIndex == 3) {
                  return sum3upDown;
                } else if (colIndex == 4) {
                  return sum3pred;
                }
              }
              break;
            case 'MaxMinSumCell':
              // Check if second sum cells
              if (rowIndex == 10) {
                if (colIndex == 1) {
                  return SumMaxMinCellData(
                      controller: TextEditingController(
                          text:
                              TotalSumCellData.fromJson(cell).controller.text),
                      totalSum: sum2total,
                      oneValue: value1down,
                      maxValue: maxDown,
                      minValue: minDown);
                } else if (colIndex == 2) {
                  return SumMaxMinCellData(
                      controller: TextEditingController(
                          text:
                              TotalSumCellData.fromJson(cell).controller.text),
                      totalSum: sum2total,
                      oneValue: value1up,
                      maxValue: maxUp,
                      minValue: minUp);
                } else if (colIndex == 3) {
                  return SumMaxMinCellData(
                      controller: TextEditingController(
                          text:
                              TotalSumCellData.fromJson(cell).controller.text),
                      totalSum: sum2total,
                      oneValue: value1upDown,
                      maxValue: maxUpDown,
                      minValue: minUpDown);
                } else if (colIndex == 4) {
                  return SumMaxMinCellData(
                      controller: TextEditingController(
                          text:
                              TotalSumCellData.fromJson(cell).controller.text),
                      totalSum: sum2total,
                      oneValue: value1pred,
                      maxValue: maxPred,
                      minValue: minPred);
                }
              }
              break;
            case 'TotalRowSumCell':
              // Check if first sum cells
              if (rowIndex == 7) {
                sum1total.controller.text =
                    TotalRowSumCellData.fromJson(cell).controller.text;
                return sum1total;
              }
              // Check if second sum cells
              else if (rowIndex == 10) {
                sum2total.controller.text =
                    TotalRowSumCellData.fromJson(cell).controller.text;
                return sum2total;
              }
              // Check if third sum cells
              else if (rowIndex == 16) {
                sum3total.controller.text =
                    TotalRowSumCellData.fromJson(cell).controller.text;
                return sum3total;
              }
              break;
            case 'TotalSumCell':
              totalSum.controller.text =
                  TotalSumCellData.fromJson(cell).controller.text;
              return totalSum;
            default:
              return null; // Handle cases where the type is not matched
          }
        }).toList(); // Collect the values from the columns
      }).toList(), // Collect the values from the rows
    );
  }

  bool checkIfTableIsFull(List<List> tableData) {
    //get the last down value
    //get the last down value
    String lastDownValue = tableData[15][1].controller.text;

    //get the lastUpValue
    String lastUpValue = tableData[1][2].controller.text;

    //get the updown / pred values
    int countUpDownSolvedCells = 0;
    int countPredSolvedCells = 0;
    for (int i = 1; i < tableData.length - 1; i++) {
      if (tableData[i][3].controller.text != "") {
        countUpDownSolvedCells++;
      }
      if (tableData[i][4].controller.text != "") {
        countPredSolvedCells++;
      }
    }

    //Check if lastdown value is set, last up value is set, upDown column is full, pred column is full
    if (lastDownValue != "" &&
        lastUpValue != "" &&
        countUpDownSolvedCells == 16 &&
        countPredSolvedCells == 16) {
      return true;
    } else {
      return false;
    }
  }
}
