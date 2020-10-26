import 'package:flutter/material.dart';
import 'package:crono/pages/home.dart';
import 'package:crono/pages/crono.dart';

void main() => runApp(MaterialApp(
        theme:
            ThemeData(appBarTheme: AppBarTheme(color: Colors.redAccent[700])),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/Crono': (context) => CronoPage(),
        }));
