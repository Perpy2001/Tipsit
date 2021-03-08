import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInProvider  extends   ChangeNotifier{
  final gogleSingIn=GoogleSignIn();
  bool _isSingingIn;

  GoogleSingInProvider(){
    _isSingingIn=false;
  }
bool get isSingingIn=>_isSingingIn;

set isSingingIn(bool isSingingIn){
  _isSingingIn =isSingingIn;
  notifyListeners();
}

  Future login() async{
_isSingingIn = true;
final user = await gogleSingIn.signIn();
if(user == null ){
  isSingingIn=false;
  return;
}else{ 
final googleAuth= await user.authentication;



final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
            await FirebaseAuth.instance.signInWithCredential(credential);

      isSingingIn = false;
      
      }
      
  }
  void logout() async {
    try{
    FirebaseAuth.instance.signOut();
    await gogleSingIn.disconnect();
    }
    catch (e){
      print(e.toString());
    }

  }


 }