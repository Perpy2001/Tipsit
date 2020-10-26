import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  Timer({Key key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

Duration _currentDuration = new Duration(hours: 0, minutes: 0, seconds: 0);

Duration _inputDuration = new Duration(hours: 0, minutes: 0, seconds: 0);

class _TimerState extends State<Timer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: FlatButton(
        onPressed: () {
          return showDialog(
            context: context,
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                color: Colors.redAccent[700],
                height: 300,
                child: Column(
                  children: [
                    CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.ms,
                      initialTimerDuration: _currentDuration,
                      onTimerDurationChanged: (duration) {
                        setState(() {
                          _inputDuration = duration;
                        });
                      },
                    ),
                    Spacer(),
                    RaisedButton(
                        color: Colors.blue[900],
                        child: Container(
                            child: Icon(
                          Icons.play_arrow,
                        )),
                        onPressed: () {
                          setState(() {
                            _currentDuration = _inputDuration;
                          });
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Center(
                    child: (Text(
                      "${snapshot.data["min"].toString().padLeft(2, "0")}:${snapshot.data["sec"].toString().padLeft(2, "0")}:${snapshot.data["mills"].toString().padRight(2, "0")}",
                      style: TextStyle(
                        color: Colors.redAccent[700],
                        letterSpacing: 20,
                        fontSize: 30,
                      ),
                    )),
                  ),
                );
              } else
                return Container(
                    child: Center(
                        child: (Text(
                  "00:00:00",
                  style: TextStyle(
                    color: Colors.redAccent[700],
                    letterSpacing: 20,
                    fontSize: 30,
                  ),
                ))));
            },
            stream: starTimer(),
          ),
        ),
      ),
    );
  }
}

Stream<Map> starTimer() async* {
  int i = _currentDuration.inMilliseconds;
  Map map = {
    'mills': _currentDuration.inMilliseconds.remainder(1000),
    'sec': _currentDuration.inSeconds.remainder(60),
    'min': _currentDuration.inMinutes,
  };
  while (i >= 0) {
    i -= 100;
    map["mills"] -= 1;
    if (i > 0) {
      if (map["mills"] < 0) {
        map["sec"] -= 1;
        map["mills"] = 9;
      } else if (map["sec"] < 0) {
        map["min"] -= 1;
        map["sec"] = 60;
      }
    }
    if (map["mills"] == -1) {
      map["mills"] = 0;
    }
    await Future.delayed(new Duration(milliseconds: 100));
    yield map;
  }
}
