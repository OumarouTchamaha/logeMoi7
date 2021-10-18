
import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/HomeScreen.dart';
import 'package:LogeMoi/screens/LoginScreen.dart';
import 'package:LogeMoi/screens/RegisterScreen.dart';
import 'package:LogeMoi/widgets/customTextFormFIield.dart';
import 'package:LogeMoi/widgets/inputTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

class ResetPwdScreen extends StatefulWidget {
  @override
  _ResetPwdScreenState createState() => _ResetPwdScreenState();
}


class _ResetPwdScreenState extends State<ResetPwdScreen> {
  String _email, _password;
  String _loginMessage = '';
  bool _loading = false;
  bool _showProgess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool _obscureText = true;
  PersistentBottomSheetController _sheetController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double abovePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom + 30;
    print(abovePadding);
    double leftHeight = screenHeight - abovePadding;

    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: white,
        appBar: null,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 0),
                child: ListView(
                  children: [
                    Container(
                      height: size.height-100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                            child: Text(
                              "Reinitialiser le Mot de Passe",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Form(
                              key: _formKey,
                              autovalidate: _autoValidate,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      InputTextField(
                                          labelText: "Adresse mail",
                                          autofocus: false,
                                          hintText: "Entrez 'adresse mail associé à votre compte",
                                          icon: IconButton(icon: Icon(FlutterIcons.email_zoc, color: primaryColor)),
                                          validate: (input) {
                                            if (input.isEmpty) {
                                              return 'Entrez une adresse mail';
                                            }
                                          },
                                          onSave: (input) => _email = input,
                                          obscureText: false),
                                    ],
                                  ),

                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      height: 45,
                                      child: RaisedButton(
                                        // padding: EdgeInsets.only(bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(35.0)),
                                        onPressed: () {
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
                                          setState(() {
                                            resetPassword();
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Container(
                                                    height: 150,
                                                      child: Column(
                                                        children: [
                                                          Text('Veuillez confirmer l\'opération via le lien qui vous à été envoyé à cette addresse  \n'
                                                              ' : '+ _email),
                                                          Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                top: 20.0, bottom: 0.0,),
                                                              child: RaisedButton(
                                                                // padding: EdgeInsets.only(bottom: 10),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    new BorderRadius.circular(
                                                                        35.0)),
                                                                onPressed: () {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType.rightToLeft,
                                                                        child: LoginScreen(),
                                                                      )
                                                                  );
                                                                },
                                                                color: darkGrey,
                                                                child: RichText(
                                                                  text: TextSpan(children: <TextSpan>[
                                                                    TextSpan(
                                                                        text: "Ok",
                                                                        style: TextStyle(
                                                                            color: white,
                                                                            fontSize: 16,
                                                                            fontWeight:
                                                                            FontWeight.bold)),
                                                                  ]),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                );
                                              });
                                        },
                                        color: primaryColor,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: "Valider",
                                                style: TextStyle(
                                                    letterSpacing: 1,
                                                    color: white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          //_message(_loginMessage),
                          // new ConditionedLoginMsg(message: _loginMessage),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  "Un email contenant la procedure de",
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "de réinitialisation vous seras envoyé",
                                ),
                              )
                            ],
                          ),

//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            children: <Widget>[
//                              FlatButton(
//                                padding: EdgeInsets.only(left: 5),
//                                onPressed: () {},
//                                child: Text(
//                                  "Mot de passe Oublié",
//                                  style: TextStyle(
//                                      color: primaryColor,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                            ],
//                          )
                        ],
                      ),
                    ),
                    //Padding(padding: EdgeInsets.only(top: size.height * 0.33)),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Vous n'avez pas de compte?"),
                                FlatButton(
                                  padding: EdgeInsets.only(right: 20),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.downToUp,
                                            child: RegisterScreen()));
                                  },
                                  child: Text(
                                    "S'enregistrer ",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> resetPassword() async {
    final FormState formState = _formKey.currentState;
    if (formState.validate()) {
      try {
        formState.save();
        _showProgess = !_showProgess;

        FirebaseAuth.instance
            .sendPasswordResetEmail(email: _email);
        User loggedUser =  await FirebaseAuth.instance.currentUser;
        print(loggedUser.uid);

        Navigator.pop(context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ResetPwdScreen(),
            ));



      } catch (e) {
        print(e.code);
        switch (e.code) {
          case "user-not-found":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage =
                "Aucun utilisateur trouvé, Veuillez ressayer.";

                _showProgess = !_showProgess;
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
          case "invalid-email":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage =
                "Entrez Une Adresse mail valide";

                _showProgess = !_showProgess;
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
          case "wrong-password":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage = "Le mot mot de passe et l'adresse mail ne correspondent pas.";
                _showProgess = !_showProgess;
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
          case "network-request-failed":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage = "Erreur de connexion. Veuillez Vérifier votre connexion Internet";
                _showProgess = !_showProgess;
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
                _loginMessage = "";
              });
            }
        }
      }
  }
}
}
