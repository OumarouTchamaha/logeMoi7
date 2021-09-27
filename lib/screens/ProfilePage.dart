import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/DisplayMyEntries.dart';
import 'package:LogeMoi/screens/SplashScreen.dart';
import 'package:LogeMoi/widgets/ProfileRadioList.dart';
import 'package:LogeMoi/widgets/inputTextField.dart';
import 'package:LogeMoi/widgets/registerRadioList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  final User loggedUser;

  ProfilePage({this.loggedUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  String _radioItem;
  bool _status = true;

  String _nom, _prenom, _email, _pseudo, _typeCompte, _password, _passwordConf;
  int _mobile;

  final FocusNode myFocusNode = FocusNode();

  DocumentSnapshot userInfo;

  String _getTypeCompte(String type) {
    _radioItem = type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text('Mon Profile'),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(FlutterIcons.log_out_ent),
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 'Deconnexion',
                    child: FlatButton.icon(
                        onPressed: () {
                          handleSignOut();
                        },
                        icon: Icon(FlutterIcons.log_out_ent),
                        label: Text('Deconnexion')))
              ],
              padding: EdgeInsets.all(0.0),
              offset: Offset(0, 80),
            ),
            Padding(padding: EdgeInsets.only(right: 10))
          ],
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 205.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.account_circle, size: 200),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.loggedUser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Center(
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,));
                        }
                        userInfo = snapshot.data;
                        return  !widget.loggedUser.isAnonymous ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userInfo.data()['typeCompte'] != 'Client' ? RaisedButton(
                                    child: new Text("Mes Annonces"),
                                    textColor: Colors.white,
                                    color: primaryColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: DisplayMyEntries(
                                            loggedUser: widget.loggedUser,
                                          ),
                                        ),
                                      );
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(20.0)),
                                  ) : Container(),
                                ],
                              ),
                            ),
                            Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Information Personnel',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
//                                            new Column(
//                                              mainAxisAlignment:
//                                                  MainAxisAlignment.end,
//                                              mainAxisSize: MainAxisSize.min,
//                                              children: <Widget>[
//                                                _status
//                                                    ? _getEditIcon()
//                                                    : new Container(),
//                                              ],
//                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new InputTextField(
                                                labelText: "Pseudo",
                                                enabled: !_status,
                                                autofocus: !_status,
                                                hintText:
                                                    userInfo.data()['pseudo'],
                                                validate: (input) {
                                                  if (input.isEmpty) {
                                                    return 'Entrez un pseudo';
                                                  }
                                                },
                                                onSave: (input) =>
                                                    _pseudo = input,
                                                obscureText: false)
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new InputTextField(
                                                labelText: "Nom",
                                                enabled: !_status,
                                                autofocus: !_status,
                                                hintText:
                                                    userInfo.data()['nom'],
                                                validate: (input) {
                                                  if (input.isEmpty) {
                                                    return 'Entrez un nom';
                                                  }
                                                },
                                                onSave: (input) =>
                                                    _pseudo = input,
                                                obscureText: false)
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new InputTextField(
                                                labelText: "Prenom",
                                                enabled: !_status,
                                                autofocus: !_status,
                                                hintText:
                                                    userInfo.data()['prenom'],
                                                validate: (input) {
                                                  if (input.isEmpty) {
                                                    return 'Entrez un nom';
                                                  }
                                                },
                                                onSave: (input) =>
                                                    _prenom = input,
                                                obscureText: false)
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new InputTextField(
                                                labelText: "Email affiché",
                                                enabled: !_status,
                                                autofocus: !_status,
                                                hintText:
                                                    userInfo.data()['email'],
                                                validate: (input) {
                                                  if (input.isEmpty) {
                                                    return 'Entrez une adresse mail valide';
                                                  }
                                                },
                                                onSave: (input) =>
                                                    _email = input,
                                                obscureText: false)
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new InputTextField(
                                                labelText: "Mobile",
                                                enabled: !_status,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                autofocus: !_status,
                                                hintText: userInfo
                                                    .data()['mobile']
                                                    .toString(),
                                                validate: (input) {
                                                  if (input.isEmpty) {
                                                    return 'Entrez un numéro de téléphone valide';
                                                  }
                                                },
                                                onSave: (input) =>
                                                    _mobile = input,
                                                obscureText: false)
                                          ],
                                        )),
                                    !_status
                                        ? _getActionButtons()
                                        : new Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ) : Container();
                      }),
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: primaryColor,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: darkGrey,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Future<Null> handleSignOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight, child: SplashScreen()),
        (Route<dynamic> route) => false);

//    Navigator.of(context).pushAndRemoveUntil(
//        MaterialPageRoute(builder: (context) => SplashScreen()),
//            (Route < dynamic > route) => false);
  }
}
