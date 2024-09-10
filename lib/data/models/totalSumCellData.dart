import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';

class TotalSumCellData extends ChangeNotifier {
  Color color;
  TextEditingController controller;

  TotalSumCellData({
    this.color = totalScoreColor,
    required this.controller,
  }) {
    // Add a listener to the TextEditingController
    controller.addListener(_onTextChanged);
  }

  // Method to handle text change
  void _onTextChanged() {
    notifyListeners();
  }

  // Converting CellData object into a Map (JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'color': color.value,
      'controller': controller.text,
      'type': 'TotalSumCell',
    };
  }

  // Converting a Map into a CellData object
  factory TotalSumCellData.fromJson(Map<String, dynamic> json) {
    return TotalSumCellData(
      controller: TextEditingController(text: json['controller']),
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
