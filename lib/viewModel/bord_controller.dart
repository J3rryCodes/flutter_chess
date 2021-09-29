import 'package:flutter/cupertino.dart';
import 'package:flutter_chess/consents/color_constents.dart';
import 'package:flutter_chess/model/tile_model.dart';

class BordController with ChangeNotifier {
  static const int bordSize = 8;
  final List<List<TileModel>> tiles = [];

  TileModel? _selectedModel;

// PUBLIC FUNCTIONS
  initBord(double tileSize) {
    for (int i = 0; i < bordSize; i++) {
      List<TileModel> model = [];
      for (int j = 0; j < bordSize; j++) {
        model.add(TileModel(i, j,
            (i + j) % 2 == 0 ? tileColorBright : tileColorDark, tileSize));
      }
      tiles.add(model);
    }
  }

  selectTile(TileModel model) {
    if (tiles[model.columnPos][model.rowPos].isSelected) {
      tiles[model.columnPos][model.rowPos].isSelected =
          !tiles[model.columnPos][model.rowPos].isSelected;
      _selectedModel = null;
      _clear();
    } else {
      if (_selectedModel != null && model.isAllowedTile) {
        tiles[model.columnPos][model.rowPos]
            .copy(_selectedModel!.type, _selectedModel!.chesspiece);
        tiles[_selectedModel!.columnPos][_selectedModel!.rowPos]
            .copy(TileType.empty, const SizedBox());
        _selectedModel = null;
      }
      _clear();
      tiles[model.columnPos][model.rowPos].isSelected = true;
      if (_selectedModel != null) {
        _findPossibleMoves(model);
      }
    }
    _selectedModel = model;
    notifyListeners();
  }

  void _clear() {
    for (int i = 0; i < bordSize; i++) {
      for (int j = 0; j < bordSize; j++) {
        tiles[i][j].isSelected = false;
        tiles[i][j].isAllowedTile = false;
      }
    }
  }

  void _findPossibleMoves(TileModel model) {
    // BLACK PAWN
    if (model.type == TileType.blackPawn) {
      if (model.columnPos == 1 &&
          tiles[model.columnPos + 1][model.rowPos].type == TileType.empty) {
        tiles[model.columnPos + 1][model.rowPos].isAllowedTile = true;
        if (tiles[model.columnPos + 2][model.rowPos].type == TileType.empty) {
          tiles[model.columnPos + 2][model.rowPos].isAllowedTile = true;
        }
        if (model.rowPos != 7 &&
            tiles[model.columnPos + 1][model.rowPos + 1].type.index < 7 &&
            tiles[model.columnPos + 1][model.rowPos + 1].type !=
                TileType.empty) {
          tiles[model.columnPos + 1][model.rowPos + 1].isAllowedTile = true;
        }
        if (model.rowPos != 0 &&
            tiles[model.columnPos + 1][model.rowPos - 1].type.index < 7 &&
            tiles[model.columnPos + 1][model.rowPos - 1].type !=
                TileType.empty) {
          tiles[model.columnPos + 1][model.rowPos - 1].isAllowedTile = true;
        }
      }
      if (model.columnPos != 7) {
        if (tiles[model.columnPos + 1][model.rowPos].type == TileType.empty) {
          tiles[model.columnPos + 1][model.rowPos].isAllowedTile = true;
        }
        if (model.rowPos != 7 &&
            tiles[model.columnPos + 1][model.rowPos + 1].type.index < 7 &&
            tiles[model.columnPos + 1][model.rowPos + 1].type !=
                TileType.empty) {
          tiles[model.columnPos + 1][model.rowPos + 1].isAllowedTile = true;
        }
        if (model.rowPos != 0 &&
            tiles[model.columnPos + 1][model.rowPos - 1].type.index < 7 &&
            tiles[model.columnPos + 1][model.rowPos - 1].type !=
                TileType.empty) {
          tiles[model.columnPos + 1][model.rowPos - 1].isAllowedTile = true;
        }
      }
    }

    // WHITE PAWN
    else if (model.type == TileType.whitePawn) {
      if (model.columnPos == 6 &&
          tiles[model.columnPos - 1][model.rowPos].type == TileType.empty) {
        tiles[model.columnPos - 1][model.rowPos].isAllowedTile = true;
        if (tiles[model.columnPos - 2][model.rowPos].type == TileType.empty) {
          tiles[model.columnPos - 2][model.rowPos].isAllowedTile = true;
        }
        if (model.rowPos != 7 &&
            tiles[model.columnPos - 1][model.rowPos + 1].type.index >= 7 &&
            tiles[model.columnPos - 1][model.rowPos + 1].type !=
                TileType.empty) {
          tiles[model.columnPos - 1][model.rowPos + 1].isAllowedTile = true;
        }
        if (model.rowPos != 0 &&
            tiles[model.columnPos - 1][model.rowPos - 1].type.index >= 7 &&
            tiles[model.columnPos - 1][model.rowPos - 1].type !=
                TileType.empty) {
          tiles[model.columnPos - 1][model.rowPos - 1].isAllowedTile = true;
        }
      } else if (model.columnPos != 0) {
        if (tiles[model.columnPos - 1][model.rowPos].type == TileType.empty) {
          tiles[model.columnPos - 1][model.rowPos].isAllowedTile = true;
        }
        if (model.rowPos != 7 &&
            tiles[model.columnPos - 1][model.rowPos + 1].type.index >= 7 &&
            tiles[model.columnPos - 1][model.rowPos + 1].type !=
                TileType.empty) {
          tiles[model.columnPos - 1][model.rowPos + 1].isAllowedTile = true;
        }
        if (model.rowPos != 0 &&
            tiles[model.columnPos - 1][model.rowPos - 1].type.index >= 7 &&
            tiles[model.columnPos - 1][model.rowPos - 1].type !=
                TileType.empty) {
          tiles[model.columnPos - 1][model.rowPos - 1].isAllowedTile = true;
        }
      }
    }

    // BLACK ROOK
    else if (model.type == TileType.blackRook) {
      for (int i = model.rowPos + 1; i < 8; i++) {
        if (tiles[model.columnPos][i].type.index < 7) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos + 1; i < 8; i++) {
        if (tiles[i][model.rowPos].type.index < 7) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.rowPos - 1; i >= 0; i--) {
        if (tiles[model.columnPos][i].type.index < 7) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos - 1; i >= 0; i--) {
        if (tiles[i][model.rowPos].type.index < 7) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
    }
    // White ROOK
    else if (model.type == TileType.whiteRook) {
      for (int i = model.rowPos + 1; i < 8; i++) {
        if (tiles[model.columnPos][i].type.index >= 7 ||
            tiles[model.columnPos][i].type == TileType.empty) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos + 1; i < 8; i++) {
        if (tiles[i][model.rowPos].type.index >= 7 ||
            tiles[i][model.rowPos].type == TileType.empty) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.rowPos - 1; i >= 0; i--) {
        if (tiles[model.columnPos][i].type.index >= 7 ||
            tiles[model.columnPos][i].type == TileType.empty) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos - 1; i >= 0; i--) {
        if (tiles[i][model.rowPos].type.index >= 7 ||
            tiles[i][model.rowPos].type == TileType.empty) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
    }

    // BLACK KNIGHT
    else if (model.type == TileType.blackKnight) {
      List<List<int>> rules = [
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1],
        [1, 2],
        [1, -2],
        [-1, 2],
        [-1, -2]
      ];
      for (List<int> rule in rules) {
        if (model.columnPos + rule[0] < 8 &&
            model.columnPos + rule[0] >= 0 &&
            model.rowPos + rule[1] < 8 &&
            model.rowPos + rule[1] >= 0 &&
            tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
                    .type
                    .index <
                7) {
          tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
              .isAllowedTile = true;
        }
      }
    }
    // WHITE KNIGHT
    else if (model.type == TileType.whiteKnight) {
      List<List<int>> rules = [
        [2, 1],
        [2, -1],
        [-2, 1],
        [-2, -1],
        [1, 2],
        [1, -2],
        [-1, 2],
        [-1, -2]
      ];
      for (List<int> rule in rules) {
        if (model.columnPos + rule[0] < 8 &&
            model.columnPos + rule[0] >= 0 &&
            model.rowPos + rule[1] < 8 &&
            model.rowPos + rule[1] >= 0 &&
            (tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
                        .type
                        .index >=
                    7 ||
                tiles[model.columnPos + rule[0]][model.rowPos + rule[1]].type ==
                    TileType.empty)) {
          tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
              .isAllowedTile = true;
        }
      }
    }

    //BLACK BISHOP
    else if (model.type == TileType.blackBishop) {
      int c = model.columnPos + 1;
      int r = model.rowPos + 1;
      // + +
      while (c < 8 && r < 8 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r++;
      }
      // + -
      c = model.columnPos + 1;
      r = model.rowPos - 1;
      while (c < 8 && r >= 0 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r--;
      }
      // - +
      c = model.columnPos - 1;
      r = model.rowPos + 1;
      while (c >= 0 && r < 8 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r++;
      }
      // - -
      c = model.columnPos - 1;
      r = model.rowPos - 1;
      while (c >= 0 && r >= 0 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r--;
      }
    }
    //WHITE BISHOP
    else if (model.type == TileType.whiteBishop) {
      int c = model.columnPos + 1;
      int r = model.rowPos + 1;
      // + +
      while (c < 8 &&
          r < 8 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r++;
      }
      // + -
      c = model.columnPos + 1;
      r = model.rowPos - 1;
      while (c < 8 &&
          r >= 0 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r--;
      }
      // - +
      c = model.columnPos - 1;
      r = model.rowPos + 1;
      while (c >= 0 &&
          r < 8 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r++;
      }
      // - -
      c = model.columnPos - 1;
      r = model.rowPos - 1;
      while (c >= 0 &&
          r >= 0 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r--;
      }
    }

    //BLACK QUEEN
    else if (model.type == TileType.blackQueen) {
      // bishop part
      int c = model.columnPos + 1;
      int r = model.rowPos + 1;
      // + +
      while (c < 8 && r < 8 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r++;
      }
      // + -
      c = model.columnPos + 1;
      r = model.rowPos - 1;
      while (c < 8 && r >= 0 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r--;
      }
      // - +
      c = model.columnPos - 1;
      r = model.rowPos + 1;
      while (c >= 0 && r < 8 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r++;
      }
      // - -
      c = model.columnPos - 1;
      r = model.rowPos - 1;
      while (c >= 0 && r >= 0 && tiles[c][r].type.index < 7) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r--;
      }

      //rook part
      for (int i = model.rowPos + 1; i < 8; i++) {
        if (tiles[model.columnPos][i].type.index < 7) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos + 1; i < 8; i++) {
        if (tiles[i][model.rowPos].type.index < 7) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.rowPos - 1; i >= 0; i--) {
        if (tiles[model.columnPos][i].type.index < 7) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos - 1; i >= 0; i--) {
        if (tiles[i][model.rowPos].type.index < 7) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
    }
    //WHITE QUEEN
    else if (model.type == TileType.whiteQueen) {
      //bishop part
      int c = model.columnPos + 1;
      int r = model.rowPos + 1;
      // + +
      while (c < 8 &&
          r < 8 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r++;
      }
      // + -
      c = model.columnPos + 1;
      r = model.rowPos - 1;
      while (c < 8 &&
          r >= 0 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c++;
        r--;
      }
      // - +
      c = model.columnPos - 1;
      r = model.rowPos + 1;
      while (c >= 0 &&
          r < 8 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r++;
      }
      // - -
      c = model.columnPos - 1;
      r = model.rowPos - 1;
      while (c >= 0 &&
          r >= 0 &&
          (tiles[c][r].type.index >= 7 || tiles[c][r].type == TileType.empty)) {
        tiles[c][r].isAllowedTile = true;
        if (tiles[c][r].type != TileType.empty) break;
        c--;
        r--;
      }
      // rook part
      for (int i = model.rowPos + 1; i < 8; i++) {
        if (tiles[model.columnPos][i].type.index >= 7 ||
            tiles[model.columnPos][i].type == TileType.empty) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos + 1; i < 8; i++) {
        if (tiles[i][model.rowPos].type.index >= 7 ||
            tiles[i][model.rowPos].type == TileType.empty) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.rowPos - 1; i >= 0; i--) {
        if (tiles[model.columnPos][i].type.index >= 7 ||
            tiles[model.columnPos][i].type == TileType.empty) {
          if (i != model.rowPos) tiles[model.columnPos][i].isAllowedTile = true;
        }
        if (tiles[model.columnPos][i].type != TileType.empty) {
          break;
        }
      }
      for (int i = model.columnPos - 1; i >= 0; i--) {
        if (tiles[i][model.rowPos].type.index >= 7 ||
            tiles[i][model.rowPos].type == TileType.empty) {
          if (i != model.columnPos) tiles[i][model.rowPos].isAllowedTile = true;
        }
        if (tiles[i][model.rowPos].type != TileType.empty) {
          break;
        }
      }
    }

    //BLACK KING
    else if (model.type == TileType.blackKing) {
      List<List<int>> rules = [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
      ];
      for (List<int> rule in rules) {
        if (model.columnPos + rule[0] < 8 &&
            model.columnPos + rule[0] >= 0 &&
            model.rowPos + rule[1] < 8 &&
            model.rowPos + rule[1] >= 0 &&
            tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
                    .type
                    .index <
                7) {
          tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
              .isAllowedTile = true;
        }
      }
    }
    // WHITE KING
    else if (model.type == TileType.whiteKing) {
      List<List<int>> rules = [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0]
      ];
      for (List<int> rule in rules) {
        if (model.columnPos + rule[0] < 8 &&
            model.columnPos + rule[0] >= 0 &&
            model.rowPos + rule[1] < 8 &&
            model.rowPos + rule[1] >= 0 &&
            (tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
                        .type
                        .index >=
                    7 ||
                tiles[model.columnPos + rule[0]][model.rowPos + rule[1]].type ==
                    TileType.empty)) {
          tiles[model.columnPos + rule[0]][model.rowPos + rule[1]]
              .isAllowedTile = true;
        }
      }
    }
  }
}