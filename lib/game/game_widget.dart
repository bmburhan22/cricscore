import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/score_required/score_required_widget.dart';
import '/scoring_card/scoring_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'game_model.dart';
export 'game_model.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({
    super.key,
    required this.gameRef,
  });

  final DocumentReference? gameRef;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  late GameModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GameModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GamesRecord>(
      stream: GamesRecord.getDocument(widget!.gameRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final gamePageGamesRecord = snapshot.data!;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Game - ${dateTimeFormat("d/M h:mm a", gamePageGamesRecord.datetime)}',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: wrapWithModel(
                        model: _model.scoreRequiredModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ScoreRequiredWidget(
                          game: gamePageGamesRecord,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final scores = gamePageGamesRecord.scores.toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(scores.length, (scoresIndex) {
                            final scoresItem = scores[scoresIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await widget!.gameRef!
                                    .update(createGamesRecordData(
                                  batting: scoresIndex,
                                ));
                              },
                              child: wrapWithModel(
                                model: _model.scoringCardModels.getModel(
                                  scoresIndex.toString(),
                                  scoresIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: ScoringCardWidget(
                                  key: Key(
                                    'Key92p_${scoresIndex.toString()}',
                                  ),
                                  game: gamePageGamesRecord,
                                  isBatting: scoresIndex ==
                                      gamePageGamesRecord.batting,
                                  score: scoresItem,
                                  rank: functions.getRank(
                                      gamePageGamesRecord, scoresIndex),
                                ),
                              ),
                            );
                          }).divide(SizedBox(height: 10)),
                        );
                      },
                    ),
                  ].divide(SizedBox(height: 10)).around(SizedBox(height: 10)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
