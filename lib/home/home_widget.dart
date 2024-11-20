import '/backend/backend.dart';
import '/create_game/create_game_widget.dart';
import '/score_required/score_required_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.addToDates(getCurrentTimestamp);
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (dialogContext) {
                  return Dialog(
                    elevation: 0,
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    alignment: AlignmentDirectional(0, 0)
                        .resolve(Directionality.of(context)),
                    child: GestureDetector(
                      onTap: () => FocusScope.of(dialogContext).unfocus(),
                      child: Container(
                        width: 200,
                        child: CreateGameWidget(),
                      ),
                    ),
                  );
                },
              );
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8,
            child: Icon(
              Icons.add,
              color: FlutterFlowTheme.of(context).info,
              size: 24,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              'CricScore',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    final dateList = _model.dates.toList();

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(dateList.length, (dateListIndex) {
                        final dateListItem = dateList[dateListIndex];
                        return Container(
                          width: double.infinity,
                          color: Color(0x00000000),
                          child: ExpandableNotifier(
                            initialExpanded: false,
                            child: ExpandablePanel(
                              header: Text(
                                dateTimeFormat("MMMEd", dateListItem),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              collapsed: Container(),
                              expanded: StreamBuilder<List<GamesRecord>>(
                                stream: queryGamesRecord(
                                  queryBuilder: (gamesRecord) => gamesRecord
                                      .where(
                                        'datetime',
                                        isGreaterThanOrEqualTo:
                                            functions.addDays(dateListItem, 0),
                                      )
                                      .where(
                                        'datetime',
                                        isLessThan:
                                            functions.addDays(dateListItem, 1),
                                      )
                                      .orderBy('datetime', descending: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<GamesRecord> listViewGamesRecordList =
                                      snapshot.data!;

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listViewGamesRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewGamesRecord =
                                          listViewGamesRecordList[
                                              listViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 10, 0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'Game',
                                              queryParameters: {
                                                'gameRef': serializeParam(
                                                  listViewGamesRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          onLongPress: () async {
                                            await listViewGamesRecord.reference
                                                .update(createGamesRecordData(
                                              dismissed: !listViewGamesRecord
                                                  .dismissed,
                                            ));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: () {
                                                if (listViewGamesRecord
                                                    .dismissed) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .error;
                                                } else if (functions.matchWinner(
                                                        listViewGamesRecord) !=
                                                    null) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .alternate;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .accent2;
                                                }
                                              }(),
                                              border: Border.all(
                                                width: 2,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    dateTimeFormat(
                                                        "d/M h:mm a",
                                                        listViewGamesRecord
                                                            .datetime!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  wrapWithModel(
                                                    model: _model
                                                        .scoreRequiredModels
                                                        .getModel(
                                                      listViewGamesRecord
                                                          .reference.id,
                                                      listViewIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: ScoreRequiredWidget(
                                                      key: Key(
                                                        'Keyw76_${listViewGamesRecord.reference.id}',
                                                      ),
                                                      game: listViewGamesRecord,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              theme: ExpandableThemeData(
                                tapHeaderToExpand: true,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                FFButtonWidget(
                  onPressed: () async {
                    _model
                        .addToDates(functions.olderDate(_model.dates.toList()));
                    safeSetState(() {});
                  },
                  text: 'Show older',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
