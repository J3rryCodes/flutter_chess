import 'package:flutter/material.dart';
import 'package:flutter_chess/consents/color_constents.dart';
import 'package:flutter_chess/model/firebase_controller_model.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';
import 'package:flutter_chess/widgets/board_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const double border = 0;

  @override
  Widget build(BuildContext context) {
    final double totalSize =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    final bordZize = MediaQuery.of(context).size.width - (border * 2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Room ID : ${FirebaseControllerModel().roomId}"),
        backgroundColor: HexColor("#303030"),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
            height: totalSize,
            width: totalSize,
            padding: const EdgeInsets.all(border),
            child: BoardView(boardSize: bordZize)),
      )),
    );
  }
}
