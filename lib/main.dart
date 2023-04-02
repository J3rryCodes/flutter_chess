import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/pages/room_join_page.dart';
import 'package:flutter_chess/viewModel/bord_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDbtyHoK_qPKQNvLQXGbseKzcf0zyEaSgo",
        authDomain: "flutterchess-f88fa.firebaseapp.com",
        databaseURL:
            "https://flutterchess-f88fa-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "flutterchess-f88fa",
        storageBucket: "flutterchess-f88fa.appspot.com",
        messagingSenderId: "800162467068",
        appId: "1:800162467068:web:3296c775b1a87b9535db79",
        measurementId: "G-JTM9MCSBRV"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Map<int, Color> _myPrimaryColorSet = {
      50: Color.fromRGBO(95, 138, 99, .1),
      100: Color.fromRGBO(95, 138, 99, .2),
      200: Color.fromRGBO(95, 138, 99, .3),
      300: Color.fromRGBO(95, 138, 99, .4),
      400: Color.fromRGBO(95, 138, 99, .5),
      500: Color.fromRGBO(95, 138, 99, .6),
      600: Color.fromRGBO(95, 138, 99, .7),
      700: Color.fromRGBO(95, 138, 99, .8),
      800: Color.fromRGBO(95, 138, 99, .9),
      900: Color.fromRGBO(95, 138, 99, 1),
    };

    MaterialColor myPrimaryColor =
        const MaterialColor(0xFF5f8a63, _myPrimaryColorSet);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BordController(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: myPrimaryColor,
            scaffoldBackgroundColor: HexColor("#303030")),
        home: const RoomJoinPage(),
      ),
    );
  }
}
