import 'dart:math';

import 'package:Chat_Perpignano/data/data.dart';
import 'package:flutter/material.dart';

class Messaggio extends StatelessWidget {
  final String messaggio;
  const Messaggio({Key key, this.messaggio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool me = messaggio.substring(0, 2).contains("Tu");
    String userName;
    String testo;
    if (!me) {
      userName = messaggio.substring(
          messaggio.indexOf(":") + 1, messaggio.indexOf("/"));
      testo = messaggio.substring(messaggio.indexOf("/") + 1);
    } else
      testo = messaggio.substring(4);

    return Padding(
      padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: me ? Colors.cyan : Colors.greenAccent,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 3, 8, 6),
              child: Column(
                children: [
                  Text(me ? "Tu" : "$userName",
                      textAlign: me ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(testo)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
