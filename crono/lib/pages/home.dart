import 'package:crono/widget/costum-drower.dart';
import 'package:crono/widget/game.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: CostumDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Text("Cronometro & Timer"),
            Spacer(),
            IconButton(
                icon: Icon(Icons.help),
                onPressed: () => showDialog(
                    context: context,
                    child: Container(
                      height: 100,
                      child: AlertDialog(
                        backgroundColor: Color.fromRGBO(0, 0, 0, 80),
                        title: Text(
                          "Come Giocare",
                          style: TextStyle(color: Colors.redAccent[700]),
                        ),
                        content: Container(
                          child: Column(
                            children: [
                              Text(
                                "premi il quadrati col colore corrispondente alle due barre per fare un punto",
                                style: TextStyle(color: Colors.redAccent[700]),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                "difficolta:",
                                style: TextStyle(color: Colors.redAccent[700]),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FlatButton(
                                      color: difficolta == 4
                                          ? Colors.redAccent[700]
                                          : Colors.black,
                                      onPressed: () {
                                        difficolta = 4;
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        child: Text(
                                          "facile",
                                          style: TextStyle(
                                            color: difficolta == 4
                                                ? Colors.black
                                                : Colors.redAccent[700],
                                          ),
                                        ),
                                      )),
                                  FlatButton(
                                      color: difficolta == 20
                                          ? Colors.redAccent[700]
                                          : Colors.black,
                                      onPressed: () {
                                        difficolta = 20;
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        child: Text(
                                          "difficile",
                                          style: TextStyle(
                                            color: difficolta == 20
                                                ? Colors.black
                                                : Colors.redAccent[700],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              FlatButton(
                                  color: difficolta == 8
                                      ? Colors.redAccent[700]
                                      : Colors.black,
                                  onPressed: () {
                                    difficolta = 8;
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Text(
                                      "medio",
                                      style: TextStyle(
                                        color: difficolta == 8
                                            ? Colors.black
                                            : Colors.redAccent[700],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )))
          ],
        ),
      ),
      body: Center(child: Game()),
    );
  }
}
