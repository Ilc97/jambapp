import 'package:flutter/material.dart';
import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/totalRowSumCellData.dart';

class SumMaxMinCellData extends ChangeNotifier {
  TextEditingController controller;
  TotalRowSumCellData totalSum;
  CellData oneValue;
  CellData maxValue;
  CellData minValue;

  String _previousText =
      ''; // To store the previous value of the controller's text

  SumMaxMinCellData({
    required this.controller,
    required this.totalSum,
    required this.oneValue,
    required this.maxValue,
    required this.minValue,
  }) {
    // Initialize _previousText with the controller's initial value
    _previousText = controller.text;
    // Add a listener to the TextEditingController
    controller.addListener(_onTextChanged);
    oneValue.addListener(_changeValue);
    maxValue.addListener(_changeValue);
    minValue.addListener(_changeValue);
  }

  void _changeValue() {
    //Check if value one, max and min are not null, to calculate the sum.
    if (oneValue.controller.text != "" &&
        maxValue.controller.text != "" &&
        minValue.controller.text != "") {
      int oneValueInt = int.tryParse(oneValue.controller.text) ?? 0;
      int maxValueInt = int.tryParse(maxValue.controller.text) ?? 0;
      int minValueInt = int.tryParse(minValue.controller.text) ?? 0;
      controller.text = (oneValueInt * (maxValueInt - minValueInt)).toString();
    } else {
      controller.text = "0";
    }
  }

  // Method to handle text change
  void _onTextChanged() {
    //Calling function to change the value of sum
    int previousValue = int.tryParse(_previousText) ?? 0;
    int newValue = int.tryParse(controller.text) ?? 0;
    changeTotalSumValue(previousValue, newValue);

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
      'controller': controller.text,
      'type': 'MaxMinSumCell',
    };
  }

  // Converting a Map into a CellData object
  String fromJson(Map<String, dynamic> json) {
    return TextEditingController(text: json['controller']).text;
  }

  // Dispose method to remove the listener when it's no longer needed
  @override
  void dispose() {
    controller.removeListener(_onTextChanged);
    controller.dispose(); // Dispose of the controller
    super.dispose();
  }
}
