import 'dart:convert';

import 'package:jambapp/data/models/gameResult.dart';
import 'package:jambapp/ui/viewmodels/tableBuild.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String gameResultCounterKey = 'gameResultCounter';
const String gamePartialResultKey = 'partial';
TableBuild tableBuild = TableBuild();

Future<void> savePartialGame(GameResult gameResult) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert GameResult to JSON string
  String gameResultJson = jsonEncode(gameResult.toJson());
  // Store it in SharedPreferences
  await prefs.setString(gamePartialResultKey, gameResultJson);
}

Future<void> removePartialGame() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(gamePartialResultKey);
}

Future<void> saveGameResult(GameResult gameResult) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert GameResult to JSON string
  String gameResultJson = jsonEncode(gameResult.toJson());

  //Increment the ID result
  //first check if the result exists, then we are overwriting and there is no need for increment
  if (prefs.getString(gameResult.id.toString()) == null) {
    int currentId = prefs.getInt(gameResultCounterKey) ?? 0;
    // Increment the counter for the next ID
    int nextId = currentId + 1;
    // Save the updated counter value
    await prefs.setInt(gameResultCounterKey, nextId);
  }

  // Store it in SharedPreferences
  await prefs.setString(gameResult.id.toString(), gameResultJson);
}

Future<void> savePartialGameResult(
    int id, String name, int result, List<List<dynamic>> tableData) async {
  // Create a new GameResult object
  GameResult newGameResult = GameResult(
      id: id,
      name: name,
      date: DateTime.now(),
      finished: false,
      tableData: tableData,
      result: result);

  // Save the game result
  await savePartialGame(newGameResult);
}

Future<void> saveNewGameResult(int id, String name, bool finished, int result,
    List<List<dynamic>> tableData) async {
  // Create a new GameResult object
  GameResult newGameResult = GameResult(
    id: id,
    name: name,
    date: DateTime.now(),
    finished: finished,
    result: result,
    tableData: tableData,
  );

  // Save the game result
  await saveGameResult(newGameResult);
}

Future<List<GameResult>> getAllGameResult() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<GameResult> results = [];

  int i = 0;
  while (true) {
    String? gameResultJson = prefs.getString(i.toString());
    if (gameResultJson == null) break;

    Map<String, dynamic> json = jsonDecode(gameResultJson);
    GameResult result = tableBuild.rebuildTable(json, false);
    results.add(result);

    i++;
  }

  return results.reversed.toList();
}

Future<GameResult?> getPartialGameResult() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the JSON string from SharedPreferences
  String? gamePartialResultJson = prefs.getString(gamePartialResultKey);

  if (gamePartialResultJson == null) {
    return null;
  }

  // Convert the JSON string back to a GameResult object
  Map<String, dynamic> json = jsonDecode(gamePartialResultJson);

  return tableBuild.rebuildTable(json, true);
}

Future<int> getNextGameResultId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the current counter value, defaulting to 0 if it doesn't exist
  int currentId = prefs.getInt(gameResultCounterKey) ?? 0;

  return currentId;
}
