import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';

List<ScoresStruct>? buildScores(List<String>? players) {
  return players
      ?.map((p) => ScoresStruct(
            player: p,
            overEnds: [],
            runs: [],
          ))
      .toList();
}

int totalRuns(ScoresStruct score) {
  // int wides = 0, b = 0;
  // if (score.runs == null || score.runs.isEmpty) return 0;
  // return score.runs.fold(0, (a, r) {
  //   if (b % 6 == 0) wides = 0;
  //   if (r == 'Wd') {
  //     wides++;
  //     if (wides > 2) r = '1';
  //   }
  //   b++;
  //   return a + (int.tryParse(r) ?? 0);
  // });

  int total = 0;
  final runs = score.runs;
  List<int> overEnds = [...score.overEnds];
  if (overEnds.isEmpty || overEnds.last < runs.length - 1)
    overEnds.add(runs.length - 1);
  for (int i = 0; i < overEnds.length; i++) {
    List<String> overRuns =
        runs.sublist(i == 0 ? 0 : overEnds[i - 1] + 1, overEnds[i] + 1);
    total += math.max(0, overRuns.where((r) => r == 'Wd').length - 2) +
        overRuns.fold(0, (a, r) => a + (int.tryParse(r) ?? 0));
  }
  return total;
}

List<ScoresStruct> rankedScores(GamesRecord game) {
  var scores = game.scores;

  return scores.toList()
    ..sort((a, b) => totalRuns(b) != totalRuns(a)
        ? totalRuns(b) - totalRuns(a)
        : b.runs.where((r) => r != 'Wd').length !=
                a.runs.where((r) => r != 'Wd').length
            ? b.runs.where((r) => r != 'Wd').length -
                a.runs.where((r) => r != 'Wd').length
            : ballsAvailable(b.runs, game.overs) -
                ballsAvailable(a.runs, game.overs));
}

double ballsToOvers(List<String> runs) {
  int balls = runs.where((r) => r != 'Wd').length;
  return balls ~/ 6 + (balls % 6) / 10;
}

String reqRuns(GamesRecord game) {
  var highest = rankedScores(game)[0];
  var batter = notOutBatter(game) ?? game.scores[game.batting];
  int runsReq = totalRuns(highest) - totalRuns(batter);
  int ballsReq = highest.runs.where((r) => r != 'Wd').length -
      batter.runs.where((r) => r != 'Wd').length;
  return batter.player +
      (runsReq > 0
          ? ' needs to score ${runsReq + 1} runs'
          : ballsReq > 0
              ? ' needs to score a run or face ${ballsReq + 1} balls'
              : ' is leading');
}

List<int> numList(int n) {
  return List<int>.generate(n, (i) => i);
}

List<String> buttonsPopulate() {
  return ["0", "1", "4", "Wd", "W"];
}

int getRank(
  GamesRecord game,
  int idx,
) {
  return rankedScores(game).indexOf(game.scores[idx]) + 1;
}

ScoresStruct? notOutBatter(GamesRecord game) {
  var scores = game.scores;
  return ballsAvailable(scores[game.batting].runs, game.overs) > 0
      ? scores[game.batting]
      : scores.firstWhere((s) => ballsAvailable(s.runs, game.overs) > 0,
          orElse: null);
}

ScoresStruct? matchWinner(GamesRecord game) {
  var scores = game.scores;
  int balls = game.overs * 6;
  // if (scores
  //.sublist(0, scores.length - 1)
  // .every((s) =>
  //     s.runs.contains('W') ||
  // s.runs.where((r) => r != 'Wd').length == balls)) {
  if (scores.last.runs.contains('W') ||
      scores.last.runs.where((r) => r != 'Wd').length == balls ||
      scores.last == rankedScores(game).first) return rankedScores(game).first;
  // }
  return null;
}

int ballsAvailable(
  List<String> runs,
  int overs,
) {
  return runs.contains('W')
      ? 0
      : overs * 6 - runs.where((r) => r != 'Wd').length;
}

String bowler(GamesRecord game) {
  // final bowlers = game.scores.indexed
  //     .where((i) => i.$1 != game.batting)
  //     .map((i) => i.$2)
  //     .toList();
  final List bowlers = [
    for (int i = game.batting + 1; i < game.scores.length; i++)
      game.scores[i], // Players after the batter
    for (int i = 0; i < game.batting; i++)
      game.scores[i] // Wrap around to the players before the batter
  ];
  final batter = game.scores[game.batting];
  return '${bowlers[ballsToOvers(batter.runs).toInt() % bowlers.length].player} to ${batter.player}';
}

List<int> overEnds(List<String> runs) {
  List<int> lastBallIndices = [];
  int validBalls = 0;

  for (int i = 0; i < runs.length; i++) {
    validBalls +=
        runs[i] != 'Wd' ? 1 : 0; // Increment valid balls if not a wide

    if (validBalls == 6) {
      lastBallIndices.add(i); // Add index of last ball of the over
      validBalls = 0; // Reset valid ball count
    }
  }

  return lastBallIndices;
}

List<DateTime> datesOfGames(List<GamesRecord> games) {
  return games
      .map((g) => DateTime(g.datetime!.year, g.datetime!.month,
          g.datetime!.day)) // Extract date part
      .toSet() // Remove duplicates
      .toList();
}

DateTime addDays(
  DateTime date,
  int days,
) {
  return DateTime(date.year, date.month, date.day).add(Duration(days: days));
}

DateTime olderDate(List<DateTime> dates) {
  return addDays(dates.reduce((a, b) => a.isBefore(b) ? a : b), -1);
}
