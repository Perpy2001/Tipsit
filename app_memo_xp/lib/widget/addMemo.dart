
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddMemo extends StatefulWidget {
 final CollectionReference colec;
 final User user;
  AddMemo({Key key, this.colec, this.user, }) : super(key: key);

  @override
  _AddMemoState createState() => _AddMemoState();
}

class _AddMemoState extends State<AddMemo> {
  bool private=false;
  TextEditingController _controllerTitolo = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Add Memo")),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: 100,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text("titolo"),
            Flexible(
              child: TextField(
                controller: _controllerTitolo,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("nota"),
            Flexible(
              child: TextField(
                controller: _controllerBody,
                keyboardType: TextInputType.text,
              ),
            ),
            IconButton(icon: Icon(private?Icons.lock:Icons.lock_open), onPressed: (){
             setState(() {
                             private=!private;
                          });
            })
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 80, height: 25, child: Center(child: Text("Cancella"))),
          style: ButtonStyle(alignment: Alignment.bottomLeft),
        ),
        TextButton(
            onPressed: () {
              widget.colec.add({
                "date":DateTime.now(),
                "private": private,
                "titolo": _controllerTitolo.text,
                "body": _controllerBody.text,
                "accaunt": widget.user.email,
                "tags": []
              });
              Navigator.of(context).pop();
            },
            child: Container(
                width: 80, height: 25, child: Center(child: Text("Salva"))),
            style: ButtonStyle(alignment: Alignment.bottomLeft))
      ],
    );
  }
}
