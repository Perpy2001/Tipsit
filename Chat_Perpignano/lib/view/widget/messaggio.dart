import 'dart:math';

import 'package:Chat_Perpignano/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';

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
      padding: EdgeInsets.fromLTRB(8, 6, 8, 3),
      child: ChatBubble(
          backGroundColor: me ? Colors.blueAccent : Colors.greenAccent,
          alignment: me ? Alignment.topRight : Alignment.topLeft,
          clipper: ChatBubbleClipper3(
              type: me ? BubbleType.sendBubble : BubbleType.receiverBubble),
          child: Container(
            child: Column(
              children: [
                Text(me ? "Tu" : "$userName",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(
                  height: 6,
                ),
                Text(testo)
              ],
            ),
          )),
    );
  }
}
