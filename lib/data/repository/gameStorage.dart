import 'dart:convert';
import 'dart:ui';

import 'package:jambapp/data/models/cellData.dart';
import 'package:jambapp/data/models/gameResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String gameResultCounterKey = 'gameResultCounter';
const String gamePartialResultKey = 'partial';


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
  if(prefs.getString(gameResult.id.toString())==null){
    int currentId = prefs.getInt(gameResultCounterKey) ?? 0;
    // Increment the counter for the next ID
    int nextId = currentId + 1;
    // Save the updated counter value
    await prefs.setInt(gameResultCounterKey, nextId);
  }

  // Store it in SharedPreferences
  await prefs.setString(gameResult.id.toString(), gameResultJson);
}




Future<void> savePartialGameResult(int id, String name, int result, List<List<CellData>> tableData, List<bool> cellConditions, List<bool> cellConditionsZeroValues, Color sum1DownColor, Color sum1UpColor, Color sum1UpDownColor, Color sum1PredColor ) async {
  // Get the next game result ID

  // Create a new GameResult object
  GameResult newGameResult = GameResult(
    id: id,
    name: name,
    date: DateTime.now(),
    finished: false,
    result: result,
    tableData: tableData,
    cellConditions: cellConditions,
    cellConditionsZeroValues: cellConditionsZeroValues,
    sum1DownColor: sum1DownColor,
    sum1UpColor: sum1UpColor,
    sum1UpDownColor: sum1UpDownColor,
    sum1PredColor: sum1PredColor
  );

  // Save the game result
  await savePartialGame(newGameResult);
}


Future<void> saveNewGameResult(int id, String name, bool finished, int result, List<List<CellData>> tableData, List<bool> cellConditions,  List<bool> cellConditionsZeroValues, Color sum1DownColor, Color sum1UpColor, Color sum1UpDownColor, Color sum1PredColor ) async {

  // Create a new GameResult object
  GameResult newGameResult = GameResult(
    id: id,
    name: name,
    date: DateTime.now(),
    finished: finished,
    result: result,
    tableData: tableData,
    cellConditions: cellConditions,
    cellConditionsZeroValues: cellConditionsZeroValues,
    sum1DownColor: sum1DownColor,
    sum1UpColor: sum1UpColor,
    sum1UpDownColor: sum1UpDownColor,
    sum1PredColor: sum1PredColor
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
    GameResult result = GameResult.fromJson(json);
    results.add(result);

    i++;
  }

  return results.reversed.toList();
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

Future<int> getNextGameResultId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the current counter value, defaulting to 0 if it doesn't exist
  int currentId = prefs.getInt(gameResultCounterKey) ?? 0;


  return currentId;
}