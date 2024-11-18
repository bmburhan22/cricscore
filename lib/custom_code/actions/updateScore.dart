// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!


Future updateScore(String run, GamesRecord game) async {
  List<String> runs = [...game.scores[game.batting].runs, run];
  game.scores[game.batting].runs = runs;
  game.scores[game.batting].overEnds = overEnds(runs);
  if (game.scores[game.batting].overEnds.length == game.overs || run == 'W') {
    await game.reference
        .update({'batting': (game.batting + 1) % game.scores.length});
  }
  await game.reference.update({
    ...mapToFirestore({'scores': getScoresListFirestoreData(game.scores)})
  });
  // Add your function code here!
}