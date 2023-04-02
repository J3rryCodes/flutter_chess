import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/model/firebase_controller_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: FirebaseControllerModel().getLastMove(),
            builder: (context, snapshot) {
              return Text(snapshot.data!.snapshot.value.toString());
            }),
      ),
    );
  }
}
