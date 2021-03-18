
import 'package:app_memo_xp/widget/costum_drower.dart';
import 'package:app_memo_xp/widget/memocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class YourHome extends StatefulWidget {
  YourHome({Key key}) : super(key: key);

  @override
  _YourHomeState createState() => _YourHomeState();
}

class _YourHomeState extends State<YourHome> {
 CollectionReference _colecMemo;
  final user = FirebaseAuth.instance.currentUser;
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
                                  "tags":[]
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
        child: StreamBuilder(
          stream: _colecMemo.where("accaunt",isEqualTo: user.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2))),
                child: ListView(
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
      ),
    );
  }
}