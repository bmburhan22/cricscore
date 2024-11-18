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

Future deleteRun(GamesRecord game) async {
  // Add your function code here!
  game.scores[game.batting].runs.removeLast();
  game.scores[game.batting].overEnds = overEnds(game.scores[game.batting].runs);
  await game.reference.update({
    ...mapToFirestore({'scores': getScoresListFirestoreData(game.scores)})
  });
}