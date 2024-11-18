import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_game_model.dart';
export 'create_game_model.dart';

class CreateGameWidget extends StatefulWidget {
  const CreateGameWidget({super.key});

  @override
  State<CreateGameWidget> createState() => _CreateGameWidgetState();
}

class _CreateGameWidgetState extends State<CreateGameWidget> {
  late CreateGameModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateGameModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.lastGame = await queryGamesRecordOnce(
        queryBuilder: (gamesRecord) =>
            gamesRecord.orderBy('datetime', descending: true),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.players = _model.lastGame!.scores
          .map((e) => e.player)
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
    });

    _model.newPlayerTextController ??= TextEditingController(text: 'Player4');
    _model.newPlayerFocusNode ??= FocusNode();

    _model.textController2 ??= TextEditingController(text: '4');
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
        ),
      ),
      child: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Builder(
                  builder: (context) {
                    final playersList = _model.players.toList();

                    return ReorderableListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: playersList.length,
                      itemBuilder: (context, playersListIndex) {
                        final playersListItem = playersList[playersListIndex];
                        return Container(
                          key: ValueKey("ListView_zonijfjp" +
                              '_' +
                              playersListIndex.toString()),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  label: 'Delete',
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                  icon: Icons.delete_outline_rounded,
                                  onPressed: (_) async {
                                    _model.removeFromPlayers(playersListItem);
                                    safeSetState(() {});
                                    _model.player =
                                        await queryPlayersRecordOnce(
                                      queryBuilder: (playersRecord) =>
                                          playersRecord.where(
                                        'name',
                                        isEqualTo: playersListItem,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    await _model.player!.reference.delete();

                                    safeSetState(() {});
                                  },
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                title: Text(
                                  playersListItem,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                tileColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                dense: false,
                              ),
                            ),
                          ),
                        );
                      },
                      onReorder: (int reorderableOldIndex,
                          int reorderableNewIndex) async {
                        _model.newPlayers = await actions.reOrder(
                          _model.players.toList(),
                          reorderableOldIndex,
                          reorderableNewIndex,
                        );
                        _model.players =
                            _model.newPlayers!.toList().cast<String>();
                        safeSetState(() {});

                        safeSetState(() {});
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: TextFormField(
                  controller: _model.newPlayerTextController,
                  focusNode: _model.newPlayerFocusNode,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'New Player',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                  keyboardType: TextInputType.name,
                  validator: _model.newPlayerTextControllerValidator
                      .asValidator(context),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  var playersRecordReference = PlayersRecord.collection
                      .doc(_model.newPlayerTextController.text);
                  await playersRecordReference.set(createPlayersRecordData(
                    name: _model.newPlayerTextController.text,
                  ));
                  _model.newPlayer = PlayersRecord.getDocumentFromData(
                      createPlayersRecordData(
                        name: _model.newPlayerTextController.text,
                      ),
                      playersRecordReference);
                  safeSetState(() {
                    _model.newPlayerTextController?.text = 'Player4';
                  });
                  _model.addToPlayers(_model.newPlayer!.reference.id);
                  safeSetState(() {});

                  safeSetState(() {});
                },
                text: 'Add',
                options: FFButtonOptions(
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: TextFormField(
                  controller: _model.textController2,
                  focusNode: _model.textFieldFocusNode,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Number of overs',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                  keyboardType: TextInputType.number,
                  validator:
                      _model.textController2Validator.asValidator(context),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      context.safePop();
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
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
                  FFButtonWidget(
                    onPressed: () async {
                      await GamesRecord.collection
                          .doc(dateTimeFormat(
                              "d-M-y_HH:mm:ss", getCurrentTimestamp))
                          .set({
                        ...createGamesRecordData(
                          datetime: getCurrentTimestamp,
                          batting: 0,
                          overs: int.tryParse(_model.textController2.text),
                        ),
                        ...mapToFirestore(
                          {
                            'scores': getScoresListFirestoreData(
                              functions.buildScores(_model.players.toList()),
                            ),
                          },
                        ),
                      });
                      context.safePop();
                    },
                    text: 'Start',
                    options: FFButtonOptions(
                      height: 40,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
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
                ].divide(SizedBox(width: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
