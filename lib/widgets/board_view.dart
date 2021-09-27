import 'package:flutter/material.dart';
import 'package:flutter_chess/model/tile_model.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';
import 'package:flutter_chess/widgets/tile_view.dart';
import 'package:provider/provider.dart';

class BoardView extends StatefulWidget {
  final double boardSize;
  const BoardView({Key? key, required this.boardSize}) : super(key: key);

  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  @override
  void initState() {
    Provider.of<BordController>(context, listen: false)
        .initBord(widget.boardSize / 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Provider.of<BordController>(context)
          .tiles
          .map<Widget>((e) => _rows(e))
          .toList(),
    );
  }

  _rows(List<TileModel> tiles) {
    return Row(
      children: tiles
          .map<Widget>(
              (e) => TileView(size: widget.boardSize / 8, tileModel: e))
          .toList(),
    );
  }
}
