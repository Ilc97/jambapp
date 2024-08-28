import 'dart:convert';

import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String gameResultCounterKey = 'gameResultCounter';
const String gamePartialResultKey = 'partial';

Future<void> saveGameResult(GameResult gameResult) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert GameResult to JSON string
  String gameResultJson = jsonEncode(gameResult.toJson());

  // Store it in SharedPreferences
  await prefs.setString(gameResult.id, gameResultJson);
}

Future<void> saveNewGameResult(String name, bool finished, List<List<CellData>> tableData) async {
  // Get the next game result ID
  int nextId = await _getNextGameResultId();

  // Create a new GameResult object
  GameResult newGameResult = GameResult(
    id: 'game_$nextId',
    name: name,
    date: DateTime.now(),
    finished: finished,
    tableData: tableData,
  );

  // Save the game result
  await saveGameResult(newGameResult);
}

Future<GameResult?> getGameResult(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the JSON string from SharedPreferences
  String? gameResultJson = prefs.getString(id);

  if (gameResultJson == null) {
    return null; // No game result found with this ID
  }

  // Convert the JSON string back to a GameResult object
  Map<String, dynamic> json = jsonDecode(gameResultJson);
  return GameResult.fromJson(json);
}

Future<GameResult?> getPartialGameResult() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the JSON string from SharedPreferences
  String? gamePartialResultJson = prefs.getString(gamePartialResultKey);

  if(gamePartialResultJson == null){
    return null;
  }

  // Convert the JSON string back to a GameResult object
  Map<String, dynamic> json = jsonDecode(gamePartialResultJson);
  return GameResult.fromJson(json);

}

Future<int> _getNextGameResultId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the current counter value, defaulting to 0 if it doesn't exist
  int currentId = prefs.getInt(gameResultCounterKey) ?? 0;

  // Increment the counter for the next ID
  int nextId = currentId + 1;

  // Save the updated counter value
  await prefs.setInt(gameResultCounterKey, nextId);

  return nextId;
}