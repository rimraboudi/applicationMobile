import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
class User{
  final String uid;
  String name,email,url_img;
  String typelogin;
  User({this.uid,this.name,this.email,this.typelogin});
}

class authentification{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DatabaseReference database = FirebaseDatabase.instance.reference();

  static User user;
  static authentification _athentif;

  factory authentification() {
    if (_athentif == null) _athentif = new authentification._();
    return _athentif;
  }

  authentification._() {
    user=null;
  }








  Future reset_pass(String email) async{
    await _auth.sendPasswordResetEmail(email: email);
    return "Email à été envoyer avec Succes";
  }

  Future get_info() async{
    await database.child("patron/"+user.uid).once().then((DataSnapshot s){
      if(s.value !=null) {
        user.name = s.value['username'];
        try {
          user.url_img = s.value['url_img'];
        }catch(e){}
      }
    });
  }

  set_img(String url_img){
    user.url_img=url_img;
    database.child("patron/${user.uid}").update({
      "url_img":url_img,
    });
  }



  Future login(String email,String pass) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      user=new User(uid: result.user.uid,name: result.user.displayName,email: result.user.email,typelogin: "Email and Password");
      await get_info();
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }




  void dispose(){
    user=null;

    _auth.signOut();
  }

}
