import 'package:flutter/material.dart';
import 'package:jambapp/core/constants/colors.dart';

class CellData {
  final int index;
  final String name;
  Color color;
  Color colorOfText = textColor;
  bool isInputField;
  TextEditingController controller;
  final String imagePath;
  final List<int> allowedScore;
  
  CellData({
    required this.index,
    required this.name,
    required this.color,
    required this.isInputField,
    required this.controller,
    required this.imagePath,
    required this.allowedScore,
  });

  // Converting CellData object into a Map (JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'name': name,
      'color': color.value, 
      'isInputField': isInputField,
      'controller': controller.text,
      'imagePath': imagePath,
      'allowedScore': allowedScore,
    };
  }

  // Converting a Map into a CellData object
  factory CellData.fromJson(Map<String, dynamic> json) {
    return CellData(
      index: json['index'],
      name: json['name'],
      color: Color(json['color']),
      isInputField: json['isInputField'],
      controller: TextEditingController(text: json['controller']),
      imagePath: json['imagePath'],
      allowedScore: List<int>.from(json['allowedScore']),
    );
  }
}