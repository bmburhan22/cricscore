// import '/backend/backend.dart';
// import '/create_game/create_game_widget.dart';
import '/score_required/score_required_widget.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import '/flutter_flow/custom_functions.dart' as functions;
import 'home_widget.dart' show HomeWidget;
// import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  List<DateTime> dates = [];
  void addToDates(DateTime item) => dates.add(item);
  void removeFromDates(DateTime item) => dates.remove(item);
  void removeAtIndexFromDates(int index) => dates.removeAt(index);
  void insertAtIndexInDates(int index, DateTime item) =>
      dates.insert(index, item);
  void updateDatesAtIndex(int index, Function(DateTime) updateFn) =>
      dates[index] = updateFn(dates[index]);

  ///  State fields for stateful widgets in this page.

  // Models for ScoreRequired dynamic component.
  late FlutterFlowDynamicModels<ScoreRequiredModel> scoreRequiredModels;

  @override
  void initState(BuildContext context) {
    scoreRequiredModels = FlutterFlowDynamicModels(() => ScoreRequiredModel());
  }

  @override
  void dispose() {
    scoreRequiredModels.dispose();
  }
}
