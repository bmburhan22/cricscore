// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScoresStruct extends FFFirebaseStruct {
  ScoresStruct({
    List<String>? runs,
    String? player,
    List<int>? overEnds,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _runs = runs,
        _player = player,
        _overEnds = overEnds,
        super(firestoreUtilData);

  // "runs" field.
  List<String>? _runs;
  List<String> get runs => _runs ?? [];
  set runs(List<String>? val) => _runs = val;
  bool hasRuns() => _runs != null;
  // "player" field.
  String? _player;
  String get player => _player ?? '';
  set player(String? val) => _player = val;
  bool hasPlayer() => _player != null;
  // "overEnds" field.
  List<int>? _overEnds;
  List<int> get overEnds => _overEnds ?? [];
  set overEnds(List<int>? val) => _overEnds = val;
  bool hasOverEnds() => _overEnds != null;

  static ScoresStruct fromMap(Map<String, dynamic> data) => ScoresStruct(
        runs: (data['runs'] as List?)?.map((i)=>i as String).toList(),
        player: data['player'] as String?,
        overEnds: (data['overEnds'] as List?)?.map((i)=>i as int).toList(),
      );

  static ScoresStruct? maybeFromMap(dynamic data) =>
      data is Map ? ScoresStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'runs': _runs,
        'player': _player,
        'overEnds': _overEnds,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'runs': serializeParam(
          _runs,
          ParamType.String,
          true,
        ),
        'player': serializeParam(
          _player,
          ParamType.String,
        ),
        'overEnds': serializeParam(
          _overEnds,
          ParamType.int,
          true,
        ),
      }.withoutNulls;

  static ScoresStruct fromSerializableMap(Map<String, dynamic> data) =>
      ScoresStruct(
        runs: deserializeParam(
          data['runs'],
          ParamType.String,
          true,
        ),
        player: deserializeParam(data['player'], ParamType.String, false),
        overEnds: deserializeParam(
          data['overEnds'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'ScoresStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ScoresStruct &&
        runs == other.runs &&
        player == other.player &&
        overEnds== other.overEnds ;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([runs, player, overEnds]);
}

ScoresStruct createScoresStruct({

List<  String>? runs,
  String? player ,
List<  int>? overEnds,
  
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ScoresStruct(
      runs: runs,
      player: player,
      overEnds: overEnds,

      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ScoresStruct? updateScoresStruct(
  ScoresStruct? score, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    score
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addScoresStructData(
  Map<String, dynamic> firestoreData,
  ScoresStruct? score,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (score == null) {
    return;
  }
  if (score.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && score.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final scoreData = getScoresFirestoreData(score, forFieldValue);
  final nestedData = scoreData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = score.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getScoresFirestoreData(
  ScoresStruct? score, [
  bool forFieldValue = false,
]) {
  if (score == null) {
    return {};
  }
  final firestoreData = mapToFirestore(score.toMap());

  // Add any Firestore field values
  score.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getScoresListFirestoreData(
  List<ScoresStruct>? scores,
) =>
    scores?.map((e) => getScoresFirestoreData(e, true)).toList() ?? [];
