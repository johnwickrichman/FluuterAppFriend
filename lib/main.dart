import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teeappfriend/states/authen.dart';
import 'package:teeappfriend/states/list_all_member.dart';
import 'package:teeappfriend/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/listAllMember': (context) => const ListAllMember(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var user = sharedPreferences.getString('id');
  print('user ==> $user');

  if (user == null) {
    firstState = '/authen';
    runApp(MyApp());
  } else {
    firstState = '/listAllMember';
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: MyConstant.dark,
          elevation: 0,
        ),
      ),
      routes: map,
      initialRoute: firstState,
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
