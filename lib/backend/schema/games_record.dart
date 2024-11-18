import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GamesRecord extends FirestoreRecord {
  GamesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "datetime" field.
  DateTime? _datetime;
  DateTime? get datetime => _datetime;
  bool hasDatetime() => _datetime != null;

  // "scores" field.
  List<ScoresStruct>? _scores;
  List<ScoresStruct> get scores => _scores ?? const [];
  bool hasScores() => _scores != null;

  // "batting" field.
  int? _batting;
  int get batting => _batting ?? 0;
  bool hasBatting() => _batting != null;
  // "overs" field.
  int? _overs;
  int get overs => _overs ?? 0;
  bool hasOvers() => _overs != null;

  void _initializeFields() {
    _scores = getStructList(
      snapshotData['scores'],
      ScoresStruct.fromMap,
    );
    _datetime = snapshotData['datetime'] as DateTime?;

    _batting = castToType<int>(snapshotData['batting']);
    _overs = castToType<int>(snapshotData['overs']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('games');

  static Stream<GamesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GamesRecord.fromSnapshot(s));

  static Future<GamesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GamesRecord.fromSnapshot(s));

  static GamesRecord fromSnapshot(DocumentSnapshot snapshot) => GamesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GamesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GamesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GamesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GamesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGamesRecordData({
  DateTime? datetime,
  List<ScoresStruct>? scores,
  int? batting,
  int? overs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'datetime': datetime,
      'scores': scores,
      'batting': batting,
      'overs': overs,
    }.withoutNulls,
  );

  return firestoreData;
}

class GamesRecordDocumentEquality implements Equality<GamesRecord> {
  const GamesRecordDocumentEquality();

  @override
  bool equals(GamesRecord? e1, GamesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.datetime == e2?.datetime &&
        listEquality.equals(e1?.scores, e2?.scores) &&
        e1?.batting == e2?.batting &&
        e1?.overs == e2?.overs;
  }

  @override
  int hash(GamesRecord? e) => const ListEquality().hash([
        e?.datetime,
        e?.scores,
        e?.batting,
        e?.overs,
      ]);

  @override
  bool isValidKey(Object? o) => o is GamesRecord;
}
