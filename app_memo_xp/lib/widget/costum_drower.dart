import 'package:app_memo_xp/floor_database/database.dart';
import 'package:app_memo_xp/pages/home.dart';
import 'package:app_memo_xp/pages/preferiti.dart';
import 'package:app_memo_xp/pages/ricerca.dart';
import 'package:app_memo_xp/pages/yourMemo.dart';
import 'package:app_memo_xp/provider/g_singin.dart';
import 'package:app_memo_xp/widget/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostumDrower extends StatelessWidget {
   final AppDatabase database;

  const CostumDrower({Key key,this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(user.photoURL),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  user.displayName,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPage()),
            );
          },
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text("Profilo"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: Text("Home"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Ricerca(database: database,)),
            );
          },
          leading: Icon(
            Icons.search,
            color: Colors.black,
          ),
          title: Text("Ricerca"),
        ),
        ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => YourHome(database: database,)),
            );
          },
          leading: Icon(
            Icons.text_fields,
            color: Colors.black,
          ),
          title: Text("Le Tue Note"),
        ),
        ListTile(
          onTap: () {
                        Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Preferiti(database: database,)),);
          },
          leading: Icon(
            Icons.star,
            color: Colors.black,
          ),
          title: Text("Preferetiti"),
        ),
        ListTile(
          onTap: () {
            final provider =
                Provider.of<GoogleSingInProvider>(context, listen: false);
            provider.logout();
          },
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text("Log Out"),
        ),
      ]),
    );
  }
}
