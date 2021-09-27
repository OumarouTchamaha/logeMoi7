import 'package:LogeMoi/fonts/loge_moi_icon_icons.dart';
import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/HomeScreen.dart';
import 'package:LogeMoi/screens/LandingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showProgess = false;
  String _errorMessage = '';

  Future<User> getCurrentUser() async {
    try{
      final User _currentUser = await FirebaseAuth.instance.currentUser;
      print(_currentUser);

      if(_currentUser == null){
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: LandingScreen()));
      }
      else{

        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: HomeScreen(currentUser: _currentUser,)));

//        Navigator.pushAndRemoveUntil(context,
//            PageTransition(
//              type: PageTransitionType.rightToLeft,
//              child: HomeScreen(currentUser: _currentUser)),
//                (Route<dynamic> route) => false);

      }
    }catch (e) {
      switch (e.code) {
        case "wrong-password":
          {
            _scaffoldKey.currentState.setState(() {
              _errorMessage = "Le mot mot de passe et l'adresse mail ne correspondent pas.";
              _showProgess = !_showProgess;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(_errorMessage),
                    ),
                  );
                });
          }
          break;
        default:
          {
            _scaffoldKey.currentState.setState(() {
              _errorMessage = "Erreur Inconnue.";
              _showProgess = !_showProgess;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(_errorMessage),
                    ),
                  );
            });
          }
      }
    }

  }

//  initState(){
//    super.initState();
//      if (getCurrentUser() == null)
//        {
//          Navigator.push(
//            context,
//            PageTransition(
//                type: PageTransitionType.rightToLeft,
//                child: LandingScreen()));
//        }
//      else
//        {
////          FirebaseFirestore.instance
////              .collection("users")
////              .doc(_currentUser.uid)
////              .get()
////              .then((DocumentSnapshot result) =>
//              Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => HomeScreen()));
////                  )))
////              .catchError((err) => print(err));
//        }
//
//        //.catchError((err) => print(err));
//
//  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0.0, 0.4),//Alignment.center
                        end: Alignment.bottomCenter,
                        colors: [primaryColor, primaryDark])),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, bottom: 10, left: 10, right: 10),
                          child: new Icon(LogeMoi_icon.logo_loge_moi_01, color: Colors.white, size: 130.0,),
                        ),
                        new Container(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                          child: new Text("LogeMoi", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 100.0),
                          padding: EdgeInsets.only(top: 0.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 45,
                            child: RaisedButton(
                              // padding: EdgeInsets.only(bottom: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(35.0)),
                              onPressed: () {
                                getCurrentUser();
                              },
                              color: primaryColor,
                              child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "Continuer",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}