import 'package:flutter/material.dart';
import 'package:flutter_chess/consents/color_constents.dart';
import 'package:flutter_chess/model/firebase_controller_model.dart';
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
      onTap: () {
        debugPrint(
            "${Provider.of<BordController>(context, listen: false).currentPlayer == Provider.of<BordController>(context, listen: false).playerType}");
        if (Provider.of<BordController>(context, listen: false).currentPlayer ==
            Provider.of<BordController>(context, listen: false).playerType) {
          FirebaseControllerModel().selectPiese(
              widget.tileModel.columnPos,
              widget.tileModel.rowPos,
              Provider.of<BordController>(context, listen: false)
                  .currentPlayer);
        }
        // Provider.of<BordController>(context, listen: false)
        //     .selectTile(widget.tileModel.columnPos, widget.tileModel.rowPos);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: widget.tileModel.isSelected
              ? HexColor(selectedBorderColor)
              : HexColor(widget.tileModel.tileColor),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: widget.size / 8,
                    color: widget.tileModel.isAllowedTile
                        ? HexColor(allowedTileColor)
                        : Colors.transparent,
                  ),
                  //shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
              ),
            ),
            widget.tileModel.chesspiece,
          ],
        ),
      ),
    );
  }
}
