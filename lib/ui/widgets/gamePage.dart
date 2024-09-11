import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/core/constants/textControllers.dart';
import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/imageCellData.dart';
import 'package:jambapp/data/models/sumCellData.dart';
import 'package:jambapp/data/models/sumMaxMinCellData.dart';
import 'package:jambapp/data/models/totalRowSumCellData.dart';
import 'package:jambapp/data/models/totalSumCellData.dart';

import 'package:jambapp/data/repository/gameStorage.dart';
import 'package:jambapp/ui/viewmodels/tableBuild.dart';

class GamePage extends StatefulWidget {
  int id;
  final String gameName;
  List<List<dynamic>> tableData;

  GamePage({
    super.key,
    required this.id,
    required this.gameName,
    required this.tableData,
  });

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  TableBuild tableBuild = TableBuild();

  double cellHeight = 34.0;
  double cellWidth = 37.0;
  double topPadding = 15.0;

  @override
  void dispose() {
    super.dispose();
  }

  bool tableFinished = false;

  @override
  Widget build(BuildContext context) {
    //Setting the size of table
    var height = MediaQuery.of(context).size.height;

    if (height < 700) {
      cellHeight = 32.0;
      cellWidth = 34.5;
    } else if (height < 750) {
      cellHeight = 33.5;
      cellWidth = 36.5;
    } else if (height < 800) {
      cellHeight = 34.5;
      cellWidth = 38.5;
    } else if (height < 825) {
      cellHeight = 35.0;
      cellWidth = 39.5;
    } else if (height < 850) {
      topPadding = 15.0;
      cellHeight = 36.5;
      cellWidth = 40.0;
    } else if (height < 900) {
      topPadding = 20.0;
      cellHeight = 37.0;
      cellWidth = 41.0;
    } else if (height < 950) {
      topPadding = 30.0;
      cellHeight = 38.0;
      cellWidth = 42.0;
    } else if (height < 1100) {
      topPadding = 45.0;
      cellHeight = 40.0;
      cellWidth = 44.0;
    } else if (height > 1099) {
      topPadding = 55.0;
      cellHeight = 52.0;
      cellWidth = 57.0;
      customFontSize = 21.0;
    }

    if (widget.tableData.isEmpty) {
      widget.tableData = tableBuild.buildTable(widget.tableData);
    }
    // Show dialog if the table is finished

    return WillPopScope(
        onWillPop: () async {
          if (tableFinished) {
            return true;
          }

          bool confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: sumColor,
                title: const Text(
                  'Potrditev',
                  style: TextStyle(
                    fontFamily: "MyCustomFont",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                content: const Text(
                  'Ali zelite shraniti igro?',
                  style: TextStyle(
                    fontFamily: "MyCustomFont",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      'Preklici',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // Return false to indicate cancellation
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Zavrzi',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    onPressed: () {
                      removePartialGame();
                      Navigator.of(context)
                          .pop(true); // Return false to indicate cancellation
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Shrani',
                      style: TextStyle(
                        fontFamily: "MyCustomFont",
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    onPressed: () {
                      savePartialGameResult(
                          widget.id, widget.gameName, 0, widget.tableData);
                      Navigator.of(context)
                          .pop(true); // Return true to indicate confirmation
                    },
                  ),
                ],
              );
            },
          );

          return confirm; // If confirm is null, default to false
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              widget.gameName,
              style: TextStyle(
                fontFamily: customFont,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: primaryColor,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image(
                    image: bgImage, // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                // Foreground content
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: topPadding),
                            child: Table(
                              defaultColumnWidth: FixedColumnWidth(cellWidth),
                              children: widget.tableData.map((row) {
                                return TableRow(
                                  children: row.map((cell) {
                                    return TableCell(
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: (cell is CellData)
                                            ? _buildCellWidget(cell)
                                            : (cell is ImageCellData)
                                                ? _buildImageWidget(cell)
                                                : (cell is SumCellData)
                                                    ? _buildSumCellWidget(cell)
                                                    : (cell
                                                            is SumMaxMinCellData)
                                                        ? _buildMaxMinSumCellWidget(
                                                            cell)
                                                        : (cell
                                                                is TotalRowSumCellData)
                                                            ? _buildTotalRowSumCellWidget(
                                                                cell)
                                                            : (cell
                                                                    is TotalSumCellData)
                                                                ? _buildTotalSumCellWidget(
                                                                    cell)
                                                                : _buildEmptyCell(),
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
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _showTableFinishedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: sumColor,
          title: Text(
            'Cestitke! Koncali ste igro!',
            style: TextStyle(
              fontFamily: customFont,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: Text(
            'Igra se je shranila pod zgodovino rezultatov.',
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
                  color: textColor,
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
    //this gets called on every change.
    return ListenableBuilder(
      listenable: cellData,
      builder: (context, child) {
        if (tableBuild.checkIfTableIsFull(widget.tableData) &&
            cellData.color != errorColor) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Ensuring the dialog and setState happen outside the build phase
            saveNewGameResult(
              widget.id,
              widget.gameName,
              true,
              int.parse(widget
                  .tableData[widget.tableData.length - 1]
                      [widget.tableData[0].length - 1]
                  .controller
                  .text),
              widget.tableData,
            );

            removePartialGame(); //there is no partial game anymore
            tableFinished = true;
            _showTableFinishedDialog(context);
          });
        }
        return Center(
            child: Container(
          alignment: Alignment.center,
          width: cellWidth,
          height: cellHeight,
          decoration: BoxDecoration(
            color: cellData.color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: _buildInputField(
              cellData.index,
              cellData.name,
              cellData.colorOfText,
              cellData.controller,
              cellData.color,
              cellData.allowedScore),
        ));
      },
    );
  }

  Widget _buildSumCellWidget(SumCellData cellData) {
    return ListenableBuilder(
        listenable: cellData,
        builder: (context, child) {
          return Center(
              child: Container(
            alignment: Alignment.center,
            width: cellWidth,
            height: cellHeight,
            decoration: BoxDecoration(
              color: cellData.color,
              borderRadius:
                  BorderRadius.circular(6.0), // Adjust the border radius here
            ),
            child: _buildSumCell(cellData.color, cellData.controller),
          ));
        });
  }

  Widget _buildMaxMinSumCellWidget(SumMaxMinCellData cellData) {
    return ListenableBuilder(
        listenable: cellData,
        builder: (context, child) {
          return Center(
              child: Container(
            alignment: Alignment.center,
            width: cellWidth,
            height: cellHeight,
            decoration: BoxDecoration(
              color: sumColor,
              borderRadius:
                  BorderRadius.circular(6.0), // Adjust the border radius here
            ),
            child: _buildSumCell(sumColor, cellData.controller),
          ));
        });
  }

  Widget _buildTotalRowSumCellWidget(TotalRowSumCellData cellData) {
    return ListenableBuilder(
        listenable: cellData,
        builder: (context, child) {
          return Center(
              child: Container(
            alignment: Alignment.center,
            width: cellWidth,
            height: cellHeight,
            decoration: BoxDecoration(
              color: cellData.color,
              borderRadius:
                  BorderRadius.circular(6.0), // Adjust the border radius here
            ),
            child: _buildSumCell(cellData.color, cellData.controller),
          ));
        });
  }

  Widget _buildTotalSumCellWidget(TotalSumCellData cellData) {
    return ListenableBuilder(
        listenable: cellData,
        builder: (context, child) {
          return Center(
              child: Container(
            alignment: Alignment.center,
            width: cellWidth,
            height: cellHeight,
            decoration: BoxDecoration(
              color: cellData.color,
              borderRadius:
                  BorderRadius.circular(6.0), // Adjust the border radius here
            ),
            child: _buildSumCell(cellData.color, cellData.controller),
          ));
        });
  }

  Widget _buildEmptyCell() {
    return Center(
        child: Container(
      alignment: Alignment.center,
      width: cellWidth,
      height: cellHeight,
      decoration: BoxDecoration(
        color: backgroundColorOfImage,
        borderRadius:
            BorderRadius.circular(6.0), // Adjust the border radius here
      ),
    ));
  }

  Widget _buildInputField(
      int index,
      String name,
      Color customTextColor,
      TextEditingController controller,
      Color cellBGColor,
      final allowedScores) {
    return Center(
        child: TextField(
      enabled: true,
      controller: controller,
      maxLength: 2,
      keyboardType: TextInputType.number,
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

  Widget _buildImageWidget(ImageCellData imageCellData) {
    return Center(
      child: Image.asset(imageCellData.imagePath, fit: BoxFit.cover),
    );
  }

  Widget _buildSumCell(Color color, TextEditingController controller) {
    return Center(
        child: TextField(
      enabled: false,
      controller: controller,
      maxLength: 2,
      keyboardType: TextInputType.number,
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
        color: textColor,
      ),
    ));
  }

  //If the app goes to background, save the game
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      savePartialGameResult(widget.id, widget.gameName, 0, widget.tableData);
    }
  }
}
