import 'package:app_memo_xp/floor_database/daos/pearson_dao.dart';
import 'package:app_memo_xp/floor_database/database.dart';
import 'package:app_memo_xp/pages/home.dart';
import 'package:app_memo_xp/provider/g_singin.dart';
import 'package:app_memo_xp/widget/sing_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper
({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final database = $FloorAppDatabase.databaseBuilder('memodatabase.db').build();
  

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context)=>GoogleSingInProvider(),
         child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<GoogleSingInProvider>(context);

              if (provider.isSingingIn) {
                return buildLoading();
              } else if (snapshot.hasData) {
                return Home();
              } else {
                return SingUp();
              }
            },
          ),
      ),
    );
  }

    Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          
          Center(child: CircularProgressIndicator()),
        ],
      );
}


