import 'package:flutter/material.dart';
import 'package:flutter_chess/model/firebase_controller_model.dart';
import 'package:flutter_chess/pages/game_page.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RoomJoinPage extends StatefulWidget {
  const RoomJoinPage({Key? key}) : super(key: key);

  @override
  _RoomJoinPageState createState() => _RoomJoinPageState();
}

class _RoomJoinPageState extends State<RoomJoinPage> {
  final TextEditingController _roomTxtCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 340,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'ENTER 5 LETTERS';
                      }
                      return null;
                    },
                    controller: _roomTxtCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      labelText: 'Room Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            Provider.of<BordController>(context, listen: false)
                                .setPlayerType(PlayerType.black);
                            FirebaseControllerModel()
                                .enterRoom(_roomTxtCtrl.text);
                            _moveToGamePage();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Join",
                              textScaleFactor: 1,
                            ),
                          )),
                      // Row(
                      //   children: const [
                      //     Expanded(
                      //         child: Divider(
                      //       color: Colors.white,
                      //     )),
                      //     Padding(
                      //       padding: EdgeInsets.all(10.0),
                      //       child: Text(
                      //         "Or",
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //     Expanded(
                      //         child: Divider(
                      //       color: Colors.white,
                      //     )),
                      //   ],
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          Provider.of<BordController>(context, listen: false)
                              .setPlayerType(PlayerType.white);
                          FirebaseControllerModel()
                              .enterRoom(_roomTxtCtrl.text);

                          FirebaseControllerModel()
                              .selectPiese(6, 4, PlayerType.white);
                          _moveToGamePage();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Create", textScaleFactor: 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveToGamePage() {
    Navigator.pushReplacement(context,
        PageTransition(child: const GamePage(), type: PageTransitionType.fade));
  }

  @override
  void dispose() {
    _roomTxtCtrl.dispose();
    super.dispose();
  }
}
