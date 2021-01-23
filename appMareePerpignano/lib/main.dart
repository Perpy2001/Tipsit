import 'dart:async';

import 'package:am029_maree/stazione.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP MAREE',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'APP MAREE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription _userAccelerometerSub;

  @override
  void initState() {
    _userAccelerometerSub =
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      // vertical gesture
    });
    super.initState();
  }

  @override
  void dispose() {
    _userAccelerometerSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/laguna.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: FutureBuilder(
            future: fetchDataList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stazione(
                        data: snapshot.data[index],
                      );
                    });
              } else
                return Text("Caricamento...");
            },
          ),
        ),
      ),
    );
  }
}
