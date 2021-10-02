import 'package:flutter/material.dart';
import 'package:flutter_chess/consents/color_constents.dart';
import 'package:flutter_chess/widgets/board_view.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double border = 0;

  @override
  Widget build(BuildContext context) {
    final totalSize = MediaQuery.of(context).size.width;
    final bordZize = MediaQuery.of(context).size.width - (border * 2);

    return Scaffold(
      backgroundColor: HexColor("#303030"),
      body: SafeArea(
          child: Center(
        child: Container(
            height: totalSize,
            width: totalSize,
            color: HexColor(borderColor),
            padding: const EdgeInsets.all(border),
            child: BoardView(boardSize: bordZize)),
      )),
    );
  }
}
