class GameResult {
  final int id;
  final String name;
  final DateTime date;
  final bool finished;
  final int result;
  final List<List<dynamic>> tableData;

  GameResult({
    required this.id,
    required this.name,
    required this.date,
    required this.finished,
    required this.result,
    required this.tableData,
  });

  // Convert a GameResult object into a Map (for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'finished': finished,
      'result': result,
      'tableData': tableData
          .map((row) => row.map((cell) {
                if (cell == null) {
                  return nullToJson(); // Properly calling the function
                }
                return cell
                    .toJson(); // Assuming you want to return the same map here
              }).toList())
          .toList(),
    };
  }

  Map<String, dynamic> nullToJson() {
    return {
      'type': 'null',
    };
  }
}
