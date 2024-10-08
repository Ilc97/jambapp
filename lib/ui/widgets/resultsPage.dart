import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jambapp/core/constants/assets.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/core/constants/textControllers.dart';
import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/data/models/imageCellData.dart';
import 'package:jambapp/data/models/sumCellData.dart';
import 'package:jambapp/data/models/sumMaxMinCellData.dart';
import 'package:jambapp/data/models/totalRowSumCellData.dart';
import 'package:jambapp/data/models/totalSumCellData.dart';
import 'package:jambapp/data/repository/gameStorage.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Zgodovina rezultatov',
          style: TextStyle(
            fontFamily: "MyCustomFont",
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
        backgroundColor: primaryColor, // Custom AppBar color
      ),
      backgroundColor: sumColor, // Custom background color
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
                String formattedDate =
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(result.date);

                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        result.name,
                        style: const TextStyle(
                          fontFamily: "MyCustomFont",
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(formattedDate),
                      trailing: Text(
                        "Rezultat: ${result.result}",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: textColor // Apply gradient color
                            ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TableResultPage(result: result),
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
  static var cellHeight = 34.0;
  static var cellWidth = 37.0;
  static var topPadding = 15.0;
  const TableResultPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(result.name),
        backgroundColor: primaryColor, // Same custom AppBar color
      ),
      backgroundColor: Colors.grey[200], // Same custom background color
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: bgImage, // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: topPadding),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(cellWidth),
                        children: result.tableData.map((row) {
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
                                              : (cell is SumMaxMinCellData)
                                                  ? _buildMaxMinSumCellWidget(
                                                      cell)
                                                  : (cell
                                                          is TotalRowSumCellData)
                                                      ? _buildTotalRowSumCellWidget(
                                                          cell)
                                                      : (cell
                                                              is TotalSumCellData)
                                                          ? _buildTotalSumCellWidget(
                                                              cell,
                                                              result.result)
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
        ),
      ),
    );
  }

  Widget _buildCellWidget(CellData cellData) {
    //this gets called on every change.
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
      readOnly: true,
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

  Widget _buildTotalSumCell(Color color, int result) {
    return Center(
        child: TextField(
      enabled: false,
      controller: TextEditingController(text: result.toString()),
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

  Widget _buildTotalSumCellWidget(TotalSumCellData cellData, int result) {
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
            child: _buildTotalSumCell(cellData.color, result),
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
}
