import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';
import 'package:jambapp/data/models/sumCellData.dart';

class CellData extends ChangeNotifier {
  final int index;
  final String name;
  Color color;
  Color colorOfText = textColor;
  bool isInputField;
  TextEditingController controller;
  final List<int> allowedScore;
  SumCellData sumCell;
  bool maxMinCell;

  String _previousText =
      ''; // To store the previous value of the controller's text
  CellData({
    required this.index,
    required this.name,
    required this.color,
    required this.isInputField,
    required this.controller,
    required this.allowedScore,
    required this.sumCell,
    required this.maxMinCell,
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
    if (!maxMinCell) {
      changeSumValue(previousValue, newValue);
    }

    //Checking if the score is correct, zero, empty (for color change).
    int controllerValue = int.tryParse(controller.text) ?? -1;
    if (allowedScore.isNotEmpty && controllerValue >= 0) {
      if (allowedScore.contains(controllerValue)) {
        color = cellBGColor; //correct
      } else {
        color = errorColor; //wrong
      }

      if (controllerValue == 0 &&
          allowedScore.contains(controllerValue) &&
          controller.text != "") {
        color = zeroValueColor; //zero value
      }
    } else {
      color = cellBGColor; //empty
    }

    // Update _previousText to the new text value for the next change
    _previousText = controller.text;
    // Notify listeners that the text has changed
    notifyListeners();
  }

  void changeSumValue(int previousValue, int newValue) {
    //first get text from sum
    int sumValue = int.tryParse(sumCell.controller.text) ?? 0;

    //Check if its first row sum - different logic
    if (sumCell.firstRowSum) {
      changeFirstRowSum(sumValue, previousValue, newValue);
    } else {
      //get new value of sum
      int newSumValue = sumValue - previousValue + newValue;

      //update it.
      sumCell.controller.text = newSumValue.toString();
    }
  }

  void changeFirstRowSum(int sumValue, int previousValue, int newValue) {
    int newSumValue = 0;

    //first we check if the sum is over 60. If it is we subtract 30
    if (sumValue >= 60) {
      sumValue -= 30;
    }

    newSumValue = sumValue - previousValue + newValue;

    //We add 30 if its over 60
    if (newSumValue >= 60) {
      newSumValue += 30;
    }

    //update it.
    sumCell.controller.text = newSumValue.toString();
  }

  // Converting CellData object into a Map (JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'color': color.value,
      'controller': controller.text,
      'allowedScore': allowedScore,
      'type': 'CellData',
    };
  }

  // Converting a Map into a CellData object
  factory CellData.fromJson(Map<String, dynamic> json,
      SumCellData storedSumCell, bool inputField, bool maxMinCell) {
    return CellData(
      index: 1,
      name: 'cell',
      color: Color(json['color']),
      isInputField: inputField,
      controller: TextEditingController(text: json['controller']),
      allowedScore: List<int>.from(json['allowedScore']),
      sumCell: storedSumCell,
      maxMinCell: maxMinCell,
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
