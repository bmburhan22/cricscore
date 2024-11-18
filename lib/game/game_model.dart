import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/score_required/score_required_widget.dart';
import '/scoring_card/scoring_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'game_widget.dart' show GameWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameModel extends FlutterFlowModel<GameWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ScoreRequired component.
  late ScoreRequiredModel scoreRequiredModel;
  // Models for ScoringCard dynamic component.
  late FlutterFlowDynamicModels<ScoringCardModel> scoringCardModels;

  @override
  void initState(BuildContext context) {
    scoreRequiredModel = createModel(context, () => ScoreRequiredModel());
    scoringCardModels = FlutterFlowDynamicModels(() => ScoringCardModel());
  }

  @override
  void dispose() {
    scoreRequiredModel.dispose();
    scoringCardModels.dispose();
  }
}
