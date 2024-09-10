import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/data/models/totalRowSumCellData.dart';
import 'package:jambapp/data/models/totalSumCellData.dart';

class SumCellData extends ChangeNotifier {
  Color color;
  TextEditingController controller;
  bool firstRowSum;
  TotalRowSumCellData totalSum;

  String _previousText =
      ''; // To store the previous value of the controller's text

  SumCellData({
    required this.color,
    required this.controller,
    required this.firstRowSum,
    required this.totalSum,
  }) {
    // Initialize _previousText with the controller's initial value
    _previousText = controller.text;
    // Add a listener to the TextEditingController
    controller.addListener(_onTextChanged);
  }

  // Method to handle text change
  void _onTextChanged() {
    //Calling function to change the value of sum
    int previousValue = int.tryParse(_previousText) ?? 0;
    int newValue = int.tryParse(controller.text) ?? 0;
    changeTotalSumValue(previousValue, newValue);
    //If it is first row sum, there should be green color
    // if its over 60
    if (firstRowSum) {
      if (int.tryParse(controller.text)! >= 60) {
        color = sumCorrectColor;
      } else {
        color = sumColor;
      }
    }

    _previousText = controller.text;
    notifyListeners();
  }

  void changeTotalSumValue(int previousValue, int newValue) {
    //first get text from totalsum
    int totalSumValue = int.tryParse(totalSum.controller.text) ?? 0;

    //get new value of sum
    int newSumValue = totalSumValue - previousValue + newValue;

    //update it.
    totalSum.controller.text = newSumValue.toString();
  }

  // Converting CellData object into a Map (JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'color': color.value,
      'controller': controller.text,
      'type': 'SumCellData',
    };
  }

  // Converting a Map into a CellData object
  factory SumCellData.fromJson(Map<String, dynamic> json) {
    return SumCellData(
      color: Color(json['color']),
      controller: TextEditingController(text: json['controller']),
      firstRowSum: false,
      totalSum: TotalRowSumCellData(
          controller: TextEditingController(),
          totalSum: TotalSumCellData(controller: TextEditingController())),
    );
  }

  // Dispose method to remove the listener when it's no longer needed
  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose(); // Dispose of the controller
    super.dispose();
  }
}
