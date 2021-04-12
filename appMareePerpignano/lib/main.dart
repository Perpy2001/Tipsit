

import 'package:am029_maree/bloc/navigationBloc.dart';
import 'package:am029_maree/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'APP MAREE',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider<NavigatorBloc>(
        create: (BuildContext context) =>NavigatorBloc(_navigatorKey),
        child: MyHomePage(title: 'APP MAREE',navigatorKey: _navigatorKey,)),
    );
  }
}