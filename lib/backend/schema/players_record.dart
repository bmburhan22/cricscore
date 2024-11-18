import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlayersRecord extends FirestoreRecord {
  PlayersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null; 

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
}

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('players');

  static Stream<PlayersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlayersRecord.fromSnapshot(s));

  static Future<PlayersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlayersRecord.fromSnapshot(s));

  static PlayersRecord fromSnapshot(DocumentSnapshot snapshot) => PlayersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlayersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlayersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlayersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlayersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlayersRecordData({
 
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name':name,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlayersRecordDocumentEquality implements Equality<PlayersRecord> {
  const PlayersRecordDocumentEquality();

  @override
  bool equals(PlayersRecord? e1, PlayersRecord? e2) {
    return e1?.name == e2?.name 
    ;
  }

  @override
  int hash(PlayersRecord? e) => const ListEquality().hash([
        e?.name,
      ]);

  @override
  bool isValidKey(Object? o) => o is PlayersRecord;
}
