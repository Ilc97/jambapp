import 'dart:ui';

import 'package:jambapp/data/models/cellData.dart';

class GameResult {
  final int id;
  final String name;
  final DateTime date;
  final bool finished;
  final int result;
  final List<List<CellData>> tableData;
  final List<bool> cellConditions;
  final List<bool> cellConditionsZeroValues;
  final Color sum1DownColor;
  final Color sum1UpColor;
  final Color sum1UpDownColor;
  final Color sum1PredColor;

  GameResult({
    required this.id,
    required this.name,
    required this.date,
    required this.finished,
    required this.result,
    required this.tableData,
    required this.cellConditions,
    required this.cellConditionsZeroValues,
    required this.sum1DownColor,
    required this.sum1UpColor,
    required this.sum1UpDownColor,
    required this.sum1PredColor,
  });

  // Convert a GameResult object into a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'finished': finished,
      'result': result,
      'tableData': tableData.map((row) => row.map((cell) => cell.toJson()).toList()).toList(),
      'cellConditions': cellConditions,
      'cellConditionsZeroValues': cellConditionsZeroValues,
      'sum1DownColor': sum1DownColor.value,
      'sum1UpColor': sum1UpColor.value,
      'sum1UpDownColor': sum1UpDownColor.value,
      'sum1PredColor': sum1PredColor.value,
    };
  }

  // Convert a Map into a GameResult object
  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      finished: json['finished'],
      result: json['result'],
      tableData: (json['tableData'] as List)
          .map((row) => (row as List).map((cell) => CellData.fromJson(cell)).toList())
          .toList(),
      cellConditions: List<bool>.from(json['cellConditions']),
      cellConditionsZeroValues: List<bool>.from(json['cellConditionsZeroValues']),
      sum1DownColor: Color(json['sum1DownColor']),
      sum1UpColor: Color(json['sum1UpColor']),
      sum1UpDownColor: Color(json['sum1UpDownColor']),
      sum1PredColor: Color(json['sum1PredColor']),
    );
  }
}