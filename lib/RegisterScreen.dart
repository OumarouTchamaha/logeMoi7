import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/LoginScreen.dart';
import 'package:LogeMoi/widgets/inputTextField.dart';
import 'package:LogeMoi/widgets/registerRadioList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
  String _nom, _prenom, _email, _pseudo, _typeCompte, _password, _passwordConf;
  int _mobile;
  String _loginMessage = '';
  bool _loading = false;
  bool _showProgess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double abovePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom +
        39;
    print(abovePadding);
    double leftHeight = screenHeight - abovePadding;
    print(size);
    print(leftHeight);

    bool _autofocus = true;

    String _getTypeCompte(String type){

        _typeCompte = type;

    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              //duration: Duration(milliseconds: 0),
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 0),
              child: ListView(children: <Widget>[
                Form(
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: Column(mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        child: Text(
                          "S'enregistrer",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Nom",
                              hintText: "ex: Aoudou",
                              autofocus : false,
                              validate: (input) {
                                if (input.isEmpty) {
                                  return 'Entrez un Nom';
                                }
                              },
                              onSave: (input) => _nom = input,
                              obscureText: false),
                          InputTextField(
                              labelText: "Prénom",
                              autofocus : false,
                              hintText: "ex: Ibrahim",
                              validate: null,
                              onSave: (input) => _prenom = input,
                              obscureText: false),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Email",
                              autofocus : false,
                              keyboardType: TextInputType.emailAddress,
                              hintText: "ex: ibrahim@logemoi.com",
                              validate: (input) {
                                if (input.isEmpty) {
                                  return 'Entrez une addresse mail';
                                }
                              },
                              onSave: (input) => _email = input,
                              obscureText: false),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Pseudo",
                              autofocus : false,
                              hintText: "ex: ibrahim123",
                              validate: (input) {
                                if (input.isEmpty) {
                                  return 'Entrez un pseudo';
                                }
                              },
                              onSave: (input) => _pseudo = input,
                              obscureText: false),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Mobile",
                              autofocus : false,
                              hintText: "ex: 123 456 789",
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                              validate: (input) {
                                if (input.isEmpty) {
                                  return 'Entrez votre numéro de téléphone';
                                }
                                if(int.parse(input) is! int){
                                  return 'Veuillez entrer un numéro de téléphone';
                                }
                              },
                              onSave: (input) => _mobile = int.parse(input),
                              obscureText: false),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 5),
                            child: new Text(
                              'Type de Compte',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      new RegisterRadioList(
                        value: _typeCompte,
                        getType:
                        _getTypeCompte,
                      ),

                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Mot de Passe",
                              autofocus : false,
                              icon: IconButton(icon: Icon(FlutterIcons.eye_sli, color: primaryColor,), onPressed: (){setState(() {
                                  _obscureText = !_obscureText;
                                  print(_typeCompte);

                              });}),
                              hintText: "********",
                              validate: (input) {
                                if (input.isEmpty) {
                                  return 'Votre mot ne peut pas être vide';
                                }else{
                                  _password = input;
                                }
                              },
                              onSave: (input) => _password = input,
                              obscureText: _obscureText),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          InputTextField(
                              labelText: "Confirmez le Mot de Passe",
                              autofocus : false,
                              icon: IconButton(icon: Icon(FlutterIcons.eye_sli, color: primaryColor,), onPressed: (){setState(() {
                                _obscureText2 = !_obscureText2;
                              });}),
                              hintText: "********",
                              validate: (input) {
                                if (input != _password) {
                                  return 'Les mots de passes ne correspondent pas';
                                }
                              },
                              onSave: (input) => _passwordConf = input,
                              obscureText: _obscureText2),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 45,
                          child: RaisedButton(
                            // padding: EdgeInsets.only(bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    new BorderRadius.circular(35.0)),
                            onPressed: () {
                             register();
                            },
                            color: primaryColor,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Valider",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "En vous enregistrant, vous acceptez les",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                          ),
                          FlatButton(
                            padding: EdgeInsets.only(left: 5),
                            onPressed: () {},
                            child: Text(
                              "Terms et Condition",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom:20)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              //top: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Divider(
                                    height: 8,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Vous avez déjà un compte? ",
                                        style: TextStyle(),
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.only(right: 20),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.downToUp,
                                                  child: LoginScreen()));
                                        },
                                        child: Text(
                                          "Connectez-vous ",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]
                      ),
                       // InputTextField(labelText: "Mobile", hintText: "dave@gmail.com"),
                    ],
                  ),
                ),
              ]),
            )
        ),
      ),
    );
  }

  Future<void> register() async {
    final FormState formState = _formKey.currentState;
    if (formState.validate()) {
      try {
        formState.save();
        print(_email);
        print(_password);
        _showProgess = !_showProgess;
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
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,
                      ),
                    ),
                  )
              );
            });

        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password).then((user){
          User loggedUser =  FirebaseAuth.instance.currentUser;
          loggedUser.updateProfile(displayName: _pseudo);
          print(loggedUser.uid);
          loggedUser.reload();
          print(loggedUser.displayName);

          loggedUser.sendEmailVerification();

          final databaseReference = FirebaseFirestore.instance;
          databaseReference.collection('users').doc(loggedUser.uid).set({
            'email': _email, 'mobile' : _mobile, 'nom' : _nom, 'prenom': _prenom,
            'pseudo' : _pseudo, 'typeCompte' : _typeCompte, 'uid' : loggedUser.uid, 'mdp': _password, 'photoUrl' : ''
          });
        });
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: LoginScreen(),
          ),
        );

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
          case "weak-password":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage = "Mot de passe trop faible";
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
          case "email-already-in-use":
            {
              _scaffoldKey.currentState.setState(() {
                _loginMessage = "Addresse mail déjà utilisé.";
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
    }else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
