import 'package:jambapp/data/models/cellData.dart';

class GameResult {
  final String id;
  final String name;
  final DateTime date;
  final bool finished;
  final List<List<CellData>> tableData;

  GameResult({
    required this.id,
    required this.name,
    required this.date,
    required this.finished,
    required this.tableData,
  });

  // Convert a GameResult object into a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'finished': finished,
      'tableData': tableData.map((row) => row.map((cell) => cell.toJson()).toList()).toList(),
    };
  }

  // Convert a Map into a GameResult object
  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      finished: json['finished'],
      tableData: (json['tableData'] as List)
          .map((row) => (row as List).map((cell) => CellData.fromJson(cell)).toList())
          .toList(),
    );
  }
}