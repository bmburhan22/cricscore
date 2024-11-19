import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_game_widget.dart' show CreateGameWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateGameModel extends FlutterFlowModel<CreateGameWidget> {
  ///  Local state fields for this component.

  List<PlayersRecord> players = [];
  void addToPlayers(PlayersRecord item) => players.add(item);
  void removeFromPlayers(PlayersRecord item) => players.remove(item);
  void removeAtIndexFromPlayers(int index) => players.removeAt(index);
  void insertAtIndexInPlayers(int index, PlayersRecord item) =>
      players.insert(index, item);
  void updatePlayersAtIndex(int index, Function(PlayersRecord) updateFn) =>
      players[index] = updateFn(players[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in CreateGame widget.
  List<PlayersRecord>? plyrs;
  // Stores action output result for [Custom Action - reOrder] action in ListView widget.
  List<PlayersRecord>? newPlayers;
  // State field(s) for NewPlayer widget.
  FocusNode? newPlayerFocusNode;
  TextEditingController? newPlayerTextController;
  String? Function(BuildContext, String?)? newPlayerTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in AddPlayer widget.
  PlayersRecord? newPlayer;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newPlayerFocusNode?.dispose();
    newPlayerTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}
