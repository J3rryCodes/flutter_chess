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
    } else {
      if (model.type != TileType.empty) {
        _selectedModel = model;
      } else if (_selectedModel != null && model.isAllowedTile) {
        tiles[model.columnPos][model.rowPos]
            .copy(_selectedModel!.type, _selectedModel!.chesspiece);
        tiles[_selectedModel!.columnPos][_selectedModel!.rowPos]
            .copy(TileType.empty, const SizedBox());
        _selectedModel = null;
      }
      for (int i = 0; i < bordSize; i++) {
        for (int j = 0; j < bordSize; j++) {
          tiles[i][j].isSelected = false;
          tiles[i][j].isAllowedTile = false;
        }
      }
      tiles[model.columnPos][model.rowPos].isSelected = true;
      if (_selectedModel != null) {
        _findPossibleMoves(model);
      }
    }
    notifyListeners();
  }

  void _findPossibleMoves(TileModel model) {
    if (model.type == TileType.blackPawn) {
      if (model.columnPos == 1 &&
          tiles[model.columnPos + 1][model.rowPos].type.index < 7) {
        tiles[model.columnPos + 1][model.rowPos].isAllowedTile = true;
        if (tiles[model.columnPos + 2][model.rowPos].type.index < 6 &&
            tiles[model.columnPos + 2][model.rowPos].type == TileType.empty) {
          tiles[model.columnPos + 2][model.rowPos].isAllowedTile = true;
        }
      } else if (model.columnPos != 6 &&
          tiles[model.columnPos + 1][model.rowPos].type.index < 7) {
        tiles[model.columnPos + 1][model.rowPos].isAllowedTile = true;
      }
    }
  }
}
