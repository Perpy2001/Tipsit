import 'package:Chat_Perpignano/view/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';

void main() async {
  Socket sock = await Socket.connect('10.0.2.2', 3000);
  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(
        channel: socket,
      ),
    );
  }
}
