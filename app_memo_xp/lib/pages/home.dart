import 'package:app_memo_xp/widget/costum_drower.dart';
import 'package:app_memo_xp/widget/memocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

CollectionReference _colec;


  @override
  void initState() {
    getColec();
    super.initState();
  }

  void _onPressed() {
  _colec.get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data()["Titolo"]);
    });
  });
}

  getColec()async{
      _colec = FirebaseFirestore.instance.collection("Memo");
  }

  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),
      drawer: CostumDrower(),
      body: Container(
      child:StreamBuilder(
          stream: _colec.snapshots() ,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2))),
                      child: ListView(
                        children: snapshot.data.docs.map<Widget>((doc) {
                          bool me=false;
                          if(doc.data()["accaunt"]==user.email){
                            me=true;
                          }
                          return MemoCard(
                            me: me,
                            titolo: doc.data()["Titolo"],
                            accaunt:  doc.data()["accaunt"],
                            body:  doc.data()["body"],
                            
                          );
                        }).toList(),
                      ),
                    );
                  
            }return Container();
          },
        ),      
      ),
    );
  }
}

