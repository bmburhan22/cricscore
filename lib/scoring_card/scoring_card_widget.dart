import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'scoring_card_model.dart';
export 'scoring_card_model.dart';

class ScoringCardWidget extends StatefulWidget {
  const ScoringCardWidget({
    super.key,
    this.game,
    bool? isBatting,
    required this.score,
    required this.rank,
  }) : this.isBatting = isBatting ?? false;

  final GamesRecord? game;
  final bool isBatting;
  final ScoresStruct? score;
  final int? rank;

  @override
  State<ScoringCardWidget> createState() => _ScoringCardWidgetState();
}

class _ScoringCardWidgetState extends State<ScoringCardWidget> {
  late ScoringCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScoringCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget!.isBatting ? 500.0 : 100.0,
      constraints: BoxConstraints(
        minHeight: 100,
      ),
      decoration: BoxDecoration(
        color: widget!.isBatting
            ? FlutterFlowTheme.of(context).secondary
            : FlutterFlowTheme.of(context).alternate,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      widget!.rank == 1 ? Color(0xFF00FF5A) : Color(0x00000000),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Text(
                    valueOrDefault<String>(
                      widget!.rank?.toString(),
                      '0',
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Readex Pro',
                          fontSize: 18,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Text(
                        widget!.score!.player,
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Text(
                          '${functions.totalRuns(widget!.score!).toString()} runs in ${functions.ballsToOvers(widget!.score!.runs.toList()).toString()} ov',
                          textAlign: TextAlign.end,
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) {
              final runs = widget!.score?.runs?.toList() ?? [];

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(runs.length, (runsIndex) {
                    final runsItem = runs[runsIndex];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            runsItem,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 18,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                        if (widget!.score?.overEnds?.contains(runsIndex) ??
                            true)
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                (int ball, List<int> overEnds) {
                                  return '${overEnds.indexOf(ball) + 1} ov';
                                }(runsIndex, widget!.score!.overEnds.toList()),
                                style: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              );
            },
          ),
          if (widget!.isBatting)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 5,
                        borderWidth: 1,
                        buttonSize: 66,
                        fillColor: FlutterFlowTheme.of(context).primary,
                        icon: Icon(
                          Icons.backspace_outlined,
                          color: Colors.white,
                          size: 48,
                        ),
                        onPressed: () async {
                          await actions.deleteRun(
                            widget!.game!,
                          );
                        },
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await actions.updateScore(
                            'W',
                            widget!.game!,
                          );
                        },
                        text: 'W',
                        options: FFButtonOptions(
                          height: 48,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).error,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 32,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  if ((List<String> runs, int overs) {
                    return true ||
                        !runs.contains("W") &&
                            runs.where((r) => r != 'Wd').length < overs * 6;
                  }(widget!.score!.runs.toList(), widget!.game!.overs))
                    Flexible(
                      child: Builder(
                        builder: (context) {
                          final buttons = functions.buttonsPopulate().toList();

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.2,
                            ),
                            primary: false,
                            scrollDirection: Axis.vertical,
                            itemCount: buttons.length,
                            itemBuilder: (context, buttonsIndex) {
                              final buttonsItem = buttons[buttonsIndex];
                              return FFButtonWidget(
                                onPressed: ((List<String> runs, int overs) {
                                  return runs.contains("W") ||
                                      runs.where((r) => r != 'Wd').length >=
                                          overs * 6;
                                }(widget!.score!.runs.toList(),
                                        widget!.game!.overs))
                                    ? null
                                    : () async {
                                        await actions.updateScore(
                                          buttonsItem,
                                          widget!.game!,
                                        );
                                      },
                                text: buttonsItem,
                                options: FFButtonOptions(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).success,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 80,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
        ].divide(SizedBox(height: 10)),
      ),
    );
  }
}
