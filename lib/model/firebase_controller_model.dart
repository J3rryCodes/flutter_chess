import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';

class FirebaseControllerModel {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child("rooms/");
  late DatabaseReference _roomDatabase;
  String? roomId;

  static final FirebaseControllerModel _firebaseControllerModel =
      FirebaseControllerModel._internal();

  factory FirebaseControllerModel() {
    return _firebaseControllerModel;
  }

  FirebaseControllerModel._internal();

  createRoom() {
    debugPrint("Room Created");
    roomId = _getRandomString(6);
    _roomDatabase = _databaseRef.child("$roomId/");
  }

  joinRoom(String roomId) {
    debugPrint("Room Joind");
    _roomDatabase = _databaseRef.child("$roomId/");
  }

  selectPiese(int x, int y, PlayerType playerType) {
    _roomDatabase
        .set({"x": x, "y": y, "player_type": playerType.index}).asStream();
  }

  Stream<DatabaseEvent>? getLastMove() {
    return _roomDatabase.onValue;
  }

  String _getRandomString(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
