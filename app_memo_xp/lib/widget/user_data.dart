
import 'package:app_memo_xp/provider/g_singin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(context) {
    final user = FirebaseAuth.instance.currentUser;
              
    return ChangeNotifierProvider<GoogleSingInProvider>(
        create: (context)=>GoogleSingInProvider(),
        
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900 ,
        appBar: AppBar(),
              body: Container(
            alignment: Alignment.center,
           // color: Colors.blueGrey.shade900,
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
        Text(
          'Loggato',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16),
        CircleAvatar(
          maxRadius: 80,
          backgroundImage: NetworkImage(user.photoURL),
        ),
        SizedBox(height: 8),
        Text(
          'Name: ' + user.displayName,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          'Email: ' + user.email,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8),

              ],
            ),
          ),
      ),
    );
  }
}
