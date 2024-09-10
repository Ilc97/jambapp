/* All possible scores are final, so they are hardcoded. They are used for checking if the input score is correct.*/

// Empty rule
const List<int> emptyAllowedScore = [];

//Rules for 1-6 values
final List<int> score1 = [0, 1, 2, 3, 4, 5];
final List<int> score2 = [0, 2, 4, 6, 8, 10];
final List<int> score3 = [0, 3, 6, 9, 12, 15];
final List<int> score4 = [0, 4, 8, 12, 16, 20];
final List<int> score5 = [0, 5, 10, 15, 20, 25];
final List<int> score6 = [0, 6, 12, 18, 24, 30];

// Max and Min rules
final List<int> scoreMax = [
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30
];
final List<int> scoreMin = [
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30
];

// Special plays rules
final List<int> scorePairs = [0, 16, 18, 20, 22, 24, 26, 28, 30, 32];
final List<int> scoreStraight = [0, 35, 45];
final List<int> scoreFull = [
  0,
  37,
  38,
  39,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  56,
  57,
  58
];
final List<int> scorePoker = [0, 44, 48, 52, 56, 60, 64];
final List<int> scoreYahtzee = [0, 55, 60, 65, 70, 75, 80];

//List of all allowed scores, used in building the table
final List<List<int>> listOfAllowedScores = [
  score1,
  score2,
  score3,
  score4,
  score5,
  score6,
  emptyAllowedScore,
  scoreMax,
  scoreMin,
  emptyAllowedScore,
  scorePairs,
  scoreStraight,
  scoreFull,
  scorePoker,
  scoreYahtzee,
  emptyAllowedScore,
  emptyAllowedScore
];
