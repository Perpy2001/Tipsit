import 'package:app_memo_xp/floor_database/database.dart';
import 'package:app_memo_xp/widget/addMemo.dart';
import 'package:app_memo_xp/widget/costum_drower.dart';
import 'package:app_memo_xp/widget/memocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ricerca extends StatefulWidget {
  final AppDatabase database;

  Ricerca({Key key, this.database}) : super(key: key);

  @override
  _RicercaState createState() => _RicercaState();
}

class _RicercaState extends State<Ricerca> {
  CollectionReference _colecMemo;
  final user = FirebaseAuth.instance.currentUser;
  final _controllerRicerca = TextEditingController();
  AppDatabase database;
  @override
  void initState() {
    getColec();
    getDatabase();
    super.initState();
  }

  getDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
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
                      return AddMemo(colec: _colecMemo, user: user);
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
                    width: MediaQuery.of(context).size.width * 0.80,
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
              stream: _colecMemo.orderBy("date").where("tags",
                  arrayContainsAny: [_controllerRicerca.text]).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2))),
                    child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map<Widget>((doc) {
                        if (doc.data()["private"] == true &&
                            user.email != doc.data()["accaunt"]) {
                          return Container();
                        }
                        bool me = false;
                        if (doc.data()["accaunt"] == user.email) {
                          me = true;
                        }

                        return MemoCard(
                      date: doc.data()["date"],
                          private: doc.data()["private"],
                          database: database,
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
