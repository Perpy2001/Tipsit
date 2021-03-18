import 'package:app_memo_xp/widget/costum_drower.dart';
import 'package:app_memo_xp/widget/memocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ricerca extends StatefulWidget {
  Ricerca({Key key}) : super(key: key);

  @override
  _RicercaState createState() => _RicercaState();
}

class _RicercaState extends State<Ricerca> {
  CollectionReference _colecMemo;
  final user = FirebaseAuth.instance.currentUser;
  final _controllerRicerca = TextEditingController();
  @override
  void initState() {
    getColec();
    super.initState();
  }

  getColec() async {
    _colecMemo = FirebaseFirestore.instance.collection("Memo");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: false,

      appBar: AppBar(
        actions: [
          Text("Memo"),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController _controllerTitolo =
                          TextEditingController();
                      TextEditingController _controllerBody =
                          TextEditingController();

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
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                width: 80,
                                height: 25,
                                child: Center(child: Text("Cancella"))),
                            style: ButtonStyle(alignment: Alignment.bottomLeft),
                          ),
                          TextButton(
                              onPressed: () {
                                _colecMemo.add({
                                  "titolo": _controllerTitolo.text,
                                  "body": _controllerBody.text,
                                  "accaunt": user.email,
                                  "tags": []
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  width: 80,
                                  height: 25,
                                  child: Center(child: Text("Salva"))),
                              style:
                                  ButtonStyle(alignment: Alignment.bottomLeft))
                        ],
                      );
                    });
              })
        ],
      ),
      drawer: CostumDrower(),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                
                children: [
                  Icon(Icons.search),
                  Text("tags:"),
                  Container(
                    width: MediaQuery.of(context).size.width*0.80 ,
                    height: 50,
                    child: TextField(
                        controller: _controllerRicerca,
                        keyboardType: TextInputType.text,
                        onSubmitted: (value) {
                          setState(() {});
                        }),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _colecMemo.where("tags",
                  arrayContainsAny: [_controllerRicerca.text]).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height*0.80,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2))),
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map<Widget>((doc) {
                        bool me = false;
                        if (doc.data()["accaunt"] == user.email) {
                          me = true;
                        }

                        return MemoCard(
                          docName: doc.id,
                          tags: doc.data()["tags"],
                          me: me,
                          titolo: doc.data()["titolo"],
                          accaunt: doc.data()["accaunt"],
                          body: doc.data()["body"],
                        );
                      }).toList(),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
