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
  @override
  Widget build(BuildContext context) {
    final totalSize = MediaQuery.of(context).size.width;
    final bordZize = MediaQuery.of(context).size.width - 24;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
            height: totalSize,
            width: totalSize,
            color: HexColor(borderColor),
            padding: const EdgeInsets.all(12),
            child: BoardView(boardSize: bordZize)),
      )),
    );
  }
}
