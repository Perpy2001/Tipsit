import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'gamecontainer.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Stream<int> getRandomValues() async* {
    var random = Random();
    while (play) {
      await Future.delayed(Duration(milliseconds: 700));
      yield random.nextInt(5);
      if (punteggio > highscore) highscore = punteggio;
    }
  }

  Stream<int> timerStream() async* {
    while (play) {
      time--;
      if (time < 0) {
        updatePlay();
      }
      await Future.delayed(Duration(milliseconds: 800));
      yield time;
    }
  }

  updatePlay() {
    int score = punteggio;
    setState(() {
      time = 30;
      punteggio = 0;
      play = !play;
    });
    if (!play) {
      return showDialog(
          context: context,
          child: AlertDialog(
              backgroundColor: Color.fromRGBO(0, 0, 0, 80),
              title: Center(
                child: Text(
                  "PUNTEGGIO",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Text(
                      score.toString(),
                      style:
                          TextStyle(color: Colors.redAccent[700], fontSize: 50),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "HIGSCORE:",
                      style: TextStyle(color: Colors.redAccent[700]),
                    ),
                    Text(
                      highscore.toString(),
                      style:
                          TextStyle(color: Colors.redAccent[700], fontSize: 50),
                    ),
                  ],
                ),
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    answer = Random().nextInt(5);
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            child: StreamBuilder<Object>(
                stream: timerStream(),
                initialData: 30,
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 52,
                        ),
                      ),
                      Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                          color: Colors.redAccent[700],
                          fontSize: 50,
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            child: Text(
              "$punteggio",
              style: TextStyle(
                color: Colors.redAccent[700],
                fontSize: 30,
              ),
            ),
          ),
          Container(
            color: color[answer],
            width: MediaQuery.of(context).size.width,
            height: 50,
          ),
          Container(
            color: Colors.black,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: difficolta,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: scegliDifficolta(difficolta)),
                itemBuilder: (context, index) {
                  return StreamBuilder(
                    stream: getRandomValues(),
                    initialData: 6,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return GestureDetector(
                        child: GameContainer(color: snapshot.data),
                        onTap: () {
                          if (answer == snapshot.data && play) {
                            setState(() {
                              punteggio++;
                            });
                          }
                        },
                      );
                    },
                  );
                }),
          ),
          Container(
            color: color[answer],
            width: MediaQuery.of(context).size.width,
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () {
                    return updatePlay();
                  },
                  child: Icon(play ? Icons.pause : Icons.play_arrow),
                ),
              ),
              Text(
                "TOP: ${highscore.toString()}",
                style: TextStyle(color: Colors.redAccent[700], fontSize: 30),
              ),
            ],
          )
        ],
      ),
    );
  }
}

int scegliDifficolta(int dif) {
  if (dif == 4) return 4;
  if (dif == 8) return 4;
  if (dif == 20) return 5;
}

int difficolta = 20;
int time = 30;
int answer = Random().nextInt(5);
int highscore = 0;
bool play = false;
int punteggio = 0;
List<Color> color = [
  Colors.red,
  Colors.yellow,
  Colors.green,
  Colors.pink,
  Colors.teal,
  Colors.purple,
  Colors.grey
];
