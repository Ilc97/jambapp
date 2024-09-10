import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/data/models/totalSumCellData.dart';

class TotalRowSumCellData extends ChangeNotifier {
  Color color;
  TextEditingController controller;
  TotalSumCellData totalSum;
  String _previousText =
      ''; // To store the previous value of the controller's text

  TotalRowSumCellData({
    this.color = rowSumColor,
    required this.controller,
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
    updateTotalSum(previousValue, newValue);
    _previousText = controller.text;
    notifyListeners();
  }

  void updateTotalSum(int previousValue, int newValue) {
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
      'type': 'TotalRowSumCell',
    };
  }

  // Converting a Map into a CellData object
  factory TotalRowSumCellData.fromJson(Map<String, dynamic> json) {
    return TotalRowSumCellData(
      color: Color(json['color']),
      controller: TextEditingController(text: json['controller']),
      totalSum: TotalSumCellData(controller: TextEditingController()),
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
