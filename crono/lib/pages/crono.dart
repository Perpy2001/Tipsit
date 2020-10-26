import 'dart:async';

import 'package:flutter/material.dart';

bool buttonState = false;
bool buttonState2 = false;

class CronoPage extends StatefulWidget {
  CronoPage({Key key}) : super(key: key);

  @override
  _CronoPageState createState() => _CronoPageState();
}

class _CronoPageState extends State<CronoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("cronometro"),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder(
              stream: starCrono(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int time = snapshot.data['time'];
                  int sec = snapshot.data['sec'];
                  int min = snapshot.data['min'];
                  String stringMin;
                  String stringTime;
                  String stringSec;

                  if (min < 10) {
                    stringMin = '0$min';
                  } else
                    stringMin = '$min';
                  if (sec < 10) {
                    stringSec = '0$sec';
                  } else
                    stringSec = '$sec';
                  if (time < 10) {
                    stringTime = '0$time';
                  } else
                    stringTime = '$time';
                  return Text(
                    '$stringMin:$stringSec:$stringTime',
                    style: TextStyle(
                      color: Colors.redAccent[700],
                      letterSpacing: 20,
                      fontSize: 30,
                    ),
                  );
                }
                return Text(
                  '00:00:00',
                  style: TextStyle(
                    letterSpacing: 20,
                    fontSize: 30,
                    color: Colors.redAccent[700],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Container(
                    child: Icon(
                      buttonState ? Icons.pause : Icons.play_arrow,
                      color: Colors.redAccent[700],
                    ),
                  ),
                  onPressed: () {
                    if (buttonState) {}
                    setState(() {
                      buttonState = !buttonState;
                    });
                  },
                ),
                FlatButton(
                  child: Container(
                    child: Icon(
                      Icons.restore,
                      color: Colors.redAccent[700],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      buttonState2 = !buttonState2;
                      map = {
                        'time': 0,
                        'sec': 0,
                        'min': 0,
                      };
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Map map = {
  'time': 0,
  'sec': 0,
  'min': 0,
};
Stream<Map> starCrono() async* {
  while (buttonState) {
    await new Future.delayed(new Duration(milliseconds: 100));
    map['time']++;
    if (map['time'] >= 10) {
      map['time'] = 0;
      map['sec']++;
    }
    if (map['sec'] >= 60) {
      map['sec'] = 0;
      map['min']++;
    }
    yield map;
  }
  if (buttonState2) {
    buttonState2 = !buttonState2;
    map = {
      'time': 0,
      'sec': 0,
      'min': 0,
    };
    yield map;
  }
}
