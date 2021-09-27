import 'package:flutter/material.dart';
import 'package:flutter_chess/consents/color_constents.dart';
import 'package:flutter_chess/model/tile_model.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TileView extends StatefulWidget {
  final double size;
  final TileModel tileModel;
  const TileView({Key? key, required this.size, required this.tileModel})
      : super(key: key);

  @override
  _TileViewState createState() => _TileViewState();
}

class _TileViewState extends State<TileView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Provider.of<BordController>(context, listen: false)
          .selectTile(widget.tileModel),
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
            color: widget.tileModel.isSelected
                ? HexColor(selectedBorderColor)
                : HexColor(widget.tileModel.tileColor),
            border: Border.all(
                color: widget.tileModel.isAllowedTile
                    ? Colors.blueAccent
                    : Colors.transparent,
                width: 4)),
        alignment: Alignment.center,
        child: widget.tileModel.chesspiece,
      ),
    );
  }
}
