import 'package:LogeMoi/fonts/loge_moi_icon_icons.dart';
import 'package:LogeMoi/screens/LoginScreen.dart';
import 'package:LogeMoi/screens/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../library/Common.dart';
import 'HomeScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _loginMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: Stack(
      children: <Widget>[
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/home.jpeg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
            child: null),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 102, 47, 0.9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 5),
                      child:
                      Tab(icon: Icon(
                          LogeMoi_icon.logo_loge_moi_01,
                          size: 55,
                          color: white,
                      ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: RichText(
                          text: TextSpan(
                            semanticsLabel: "hjk",
                            text: 'LogeMoi \n',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                height: 1.15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'La Location Facile',
                                  style: TextStyle(
                                      color: Colors.grey[350],
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ))
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 45,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35.0)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: LoginScreen()));
                          },
                          color: white,
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Se Connecter",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      child: RaisedButton(
                        // padding: EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(35.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: RegisterScreen(),
                            ),
                          );
                        },
                        color: white,
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "S'enregistrer",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 45,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(35.0)),
                          onPressed: () {
                            signInAnon();
                          },
                          color: darkGrey,
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Se Connecter comme Invité",
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
                Text(
                  "LogeMoi App V 1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[350]),
                ),
              ],
            )),
      ],
    ));
  }

  Future<void> signInAnon() async {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                content: SizedBox(
                  height: 150,
                  width: 40,
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,),
                  ),
                )
            );
          });

      UserCredential user = await FirebaseAuth.instance
          .signInAnonymously();
      User loggedUser =  await FirebaseAuth.instance.currentUser;
      print(loggedUser.uid);

      Navigator.pushAndRemoveUntil(context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: HomeScreen(currentUser: loggedUser,),
          ), (Route<dynamic> route) => false);

    } catch (e) {
      print(e.code);
      switch (e.code) {

        case "network-request-failed":
          {
            _scaffoldKey.currentState.setState(() {
              _loginMessage = "Erreur de connexion. Veuillez Vérifier votre connexion Internet";
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(_loginMessage),
                    ),
                  );
                });
          }
          break;
        default:
          {
            _scaffoldKey.currentState.setState(() {
              _loginMessage = "Erreur inconnue, veuillez réessayer !";
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(_loginMessage),
                    ),
                  );
                });
          }
      }
    }
  }

}
