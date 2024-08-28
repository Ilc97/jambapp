import 'package:flutter/material.dart';

//Text styles
double customFontSize = 16.0;
String customFont = 'MyCustomFont';

//Empty text controller, where it is not needed.
TextEditingController emptyTextController = TextEditingController();


/* ================ ALL TEXT CONTROLLERS ====================================== */

//Values for 1-6 down.
TextEditingController val1DownController = TextEditingController();
TextEditingController val2DownController = TextEditingController();
TextEditingController val3DownController = TextEditingController();
TextEditingController val4DownController = TextEditingController();
TextEditingController val5DownController = TextEditingController();
TextEditingController val6DownController = TextEditingController();

//Values for 1-6 up.
TextEditingController val1UpController = TextEditingController();
TextEditingController val2UpController = TextEditingController();
TextEditingController val3UpController = TextEditingController();
TextEditingController val4UpController = TextEditingController();
TextEditingController val5UpController = TextEditingController();
TextEditingController val6UpController = TextEditingController();

//Values for 1-6 up-down.
TextEditingController val1UpDownController = TextEditingController();
TextEditingController val2UpDownController = TextEditingController();
TextEditingController val3UpDownController = TextEditingController();
TextEditingController val4UpDownController = TextEditingController();
TextEditingController val5UpDownController = TextEditingController();
TextEditingController val6UpDownController = TextEditingController();

//Values for 1-6 predictions
TextEditingController val1PredController = TextEditingController();
TextEditingController val2PredController = TextEditingController();
TextEditingController val3PredController = TextEditingController();
TextEditingController val4PredController = TextEditingController();
TextEditingController val5PredController = TextEditingController();
TextEditingController val6PredController = TextEditingController();

//SUM 1 controllers.
TextEditingController sum1downController = TextEditingController();
TextEditingController sum1upController = TextEditingController();
TextEditingController sum1upDownController = TextEditingController();
TextEditingController sum1predController = TextEditingController();
TextEditingController sum1TotalController = TextEditingController();


//Values for maximum
TextEditingController maxDownController = TextEditingController();
TextEditingController maxUpController = TextEditingController();
TextEditingController maxUpDownController = TextEditingController();
TextEditingController maxPredController = TextEditingController();

//Values for minimum
TextEditingController minDownController = TextEditingController();
TextEditingController minUpController = TextEditingController();
TextEditingController minUpDownController = TextEditingController();
TextEditingController minPredController = TextEditingController();

//SUM 2 controllers.
TextEditingController sum2downController = TextEditingController();
TextEditingController sum2upController = TextEditingController();
TextEditingController sum2upDownController = TextEditingController();
TextEditingController sum2predController = TextEditingController();
TextEditingController sum2TotalController = TextEditingController();

//Values for pairs
TextEditingController pairsDownController = TextEditingController();
TextEditingController pairsUpController = TextEditingController();
TextEditingController pairsUpDownController = TextEditingController();
TextEditingController pairsPredController = TextEditingController();

//Values for straight
TextEditingController straightDownController = TextEditingController();
TextEditingController straightUpController = TextEditingController();
TextEditingController straightUpDownController = TextEditingController();
TextEditingController straightPredController = TextEditingController();

//Values for full
TextEditingController fullDownController = TextEditingController();
TextEditingController fullUpController = TextEditingController();
TextEditingController fullUpDownController = TextEditingController();
TextEditingController fullPredController = TextEditingController();

//Values for poker
TextEditingController pokerDownController = TextEditingController();
TextEditingController pokerUpController = TextEditingController();
TextEditingController pokerUpDownController = TextEditingController();
TextEditingController pokerPredController = TextEditingController();

//Values for yahtzee
TextEditingController yahtzeeDownController = TextEditingController();
TextEditingController yahtzeeUpController = TextEditingController();
TextEditingController yahtzeeUpDownController = TextEditingController();
TextEditingController yahtzeePredController = TextEditingController();

//SUM 3 controllers.
TextEditingController sum3downController = TextEditingController();
TextEditingController sum3upController = TextEditingController();
TextEditingController sum3upDownController = TextEditingController();
TextEditingController sum3predController = TextEditingController();
TextEditingController sum3TotalController = TextEditingController();

//Total score
TextEditingController totalScore = TextEditingController();

/* ============================================================================*/

//List of controllers, used for building the table.
List<List<TextEditingController>> listOfTextControllers = [
[emptyTextController, val1DownController, val1UpController, val1UpDownController, val1PredController, emptyTextController],
[emptyTextController, val2DownController, val2UpController, val2UpDownController, val2PredController, emptyTextController],
[emptyTextController, val3DownController, val3UpController, val3UpDownController, val3PredController, emptyTextController],
[emptyTextController, val4DownController, val4UpController, val4UpDownController, val4PredController, emptyTextController],
[emptyTextController, val5DownController, val5UpController, val5UpDownController, val5PredController, emptyTextController],
[emptyTextController, val6DownController, val6UpController, val6UpDownController, val6PredController, emptyTextController],
[emptyTextController, sum1downController, sum1upController, sum1upDownController, sum1predController, sum1TotalController],
[emptyTextController, maxDownController, maxUpController, maxUpDownController, maxPredController, emptyTextController],
[emptyTextController, minDownController, minUpController, minUpDownController, minPredController, emptyTextController],
[emptyTextController, sum2downController, sum2upController, sum2upDownController, sum2predController, sum2TotalController],
[emptyTextController, pairsDownController, pairsUpController, pairsUpDownController, pairsPredController, emptyTextController],
[emptyTextController, straightDownController, straightUpController, straightUpDownController, straightPredController, emptyTextController],
[emptyTextController, fullDownController, fullUpController, fullUpDownController, fullPredController, emptyTextController],
[emptyTextController, pokerDownController, pokerUpController, pokerUpDownController, pokerPredController, emptyTextController],
[emptyTextController, yahtzeeDownController, yahtzeeUpController, yahtzeeUpDownController, yahtzeePredController, emptyTextController],
[emptyTextController, sum3downController, sum3upController, sum3upDownController, sum3predController, sum3TotalController],
[emptyTextController, emptyTextController, emptyTextController, emptyTextController, emptyTextController, totalScore]
];
