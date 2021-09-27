import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/widgets.dart';

enum TileType {
  empty,
  whitePawn,
  whiteRook,
  whiteKnight,
  whiteBishop,
  whiteQueen,
  whiteKing,
  blackPawn,
  blackRook,
  blackKnight,
  blackBishop,
  blackQueen,
  blackKing,
}

class TileModel {
  final int rowPos, columnPos;
  final String tileColor;
  bool isAllowedTile = false;
  late Widget chesspiece;
  late TileType type;

  bool isSelected = false;

  TileModel(this.columnPos, this.rowPos, this.tileColor, double tileSize) {
    if (columnPos == 1) {
      chesspiece = BlackPawn(size: tileSize);
      type = TileType.blackPawn;
    } else if (columnPos == 6) {
      chesspiece = WhitePawn(size: tileSize);
      type = TileType.whitePawn;
    } else if (columnPos == 7) {
      if (rowPos == 0 || rowPos == 7) {
        chesspiece = WhiteRook(size: tileSize);
        type = TileType.whiteRook;
      } else if (rowPos == 1 || rowPos == 6) {
        chesspiece = WhiteKnight(size: tileSize);
        type = TileType.whiteKnight;
      } else if (rowPos == 2 || rowPos == 5) {
        chesspiece = WhiteBishop(size: tileSize);
        type = TileType.whiteBishop;
      } else if (rowPos == 3) {
        chesspiece = WhiteQueen(size: tileSize);
        type = TileType.whiteQueen;
      } else {
        chesspiece = WhiteKing(size: tileSize);
        type = TileType.whiteKing;
      }
    } else if (columnPos == 0) {
      if (rowPos == 0 || rowPos == 7) {
        chesspiece = BlackRook(size: tileSize);
        type = TileType.blackRook;
      } else if (rowPos == 1 || rowPos == 6) {
        chesspiece = BlackKnight(size: tileSize);
        type = TileType.blackKnight;
      } else if (rowPos == 2 || rowPos == 5) {
        chesspiece = BlackBishop(size: tileSize);
        type = TileType.blackBishop;
      } else if (rowPos == 4) {
        chesspiece = BlackQueen(size: tileSize);
        type = TileType.blackQueen;
      } else {
        chesspiece = BlackKing(size: tileSize);
        type = TileType.blackKing;
      }
    } else {
      chesspiece = const SizedBox();
      type = TileType.empty;
    }
  }

  copy(TileType type, Widget chesspiece) {
    this.chesspiece = chesspiece;
    this.type = type;
  }
}
