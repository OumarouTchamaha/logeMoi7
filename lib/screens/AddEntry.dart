import 'dart:ui';

import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/DisplayMyEntries.dart';
import 'package:LogeMoi/screens/ProfilePage.dart';
import 'package:LogeMoi/widgets/customDropdownButton.dart';
import 'package:LogeMoi/widgets/inputTextField.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

class AddEntry extends StatefulWidget {
  User currentUser;

  AddEntry({this.currentUser});

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  File _imageSalon,
      _imageCuisine,
      _imageDouche,
      _imageChambre,
      _image1,
      _image2,
      _image3,
      _image4,
      _image5;

  bool isLoading = false;

  Timestamp _date_ajout;

  String _user_id,
      _min_mois,
      _loyer,
      _titre,
      _statut,
      _description,
      _type,
      _entry_id;

  double _salonProgress = 0.0;
  double _cuisineProgress = 0.0;
  double _doucheProgress = 0.0;
  double _chambreProgress = 0.0;

  String _salonDescription = '';
  String _cuisineDescription = '';
  String _doucheDescription = '';
  String _chambreDescription = '';

  String _salonURL = "";
  String _chambreURL = '';
  String _cuisineURL = '';
  String _doucheURL = '';

  String _image1URL;
  String _image2URL;
  String _image3URL;
  String _image4URL;
  String _image5URL;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _selectedValue;

  bool _autoValidate = false;

  String _getValue(String value) {
    _selectedValue = value;
  }

  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    String _radioItem = 'Client';

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: white,
        appBar: AppBar(
          title: Text('Ajouter une annonce'),
          centerTitle: true,
        ),
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 30.0, top: 10.0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autoValidate,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      bottom: 0.0,
                                      top: 10.0),
                                  child: Text(
                                    "Information",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 25.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Titre",
                                        autofocus: false,
                                        hintText: "ex: Chambre à louer",
                                        validate: (input) {
                                          if (input.length > 30) {
                                            return 'Le titre ne peux pas dépasser 30 caractères';
                                          }
                                          if (input.isEmpty) {
                                            return 'Le titre ne peux pas être vide';
                                          }
                                        },
                                        onSave: (input) => _titre = input,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Description",
                                        autofocus: false,
                                        hintText: "ex: Chambre à louer",
                                        validate: (input) {
                                          _description = input;
                                        },
                                        onSave: (input) => _description = input,
                                        obscureText: _obscureText),
                                  ],
                                ),

                                //dropdown
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, bottom: 20.0),
                                  child: _selectedValue != null
                                      ? CustomDropdownButton(
                                          labelText: 'Quartier',
                                          getValue: _getValue,
                                          selectedValue: _selectedValue,
                                        )
                                      : CustomDropdownButton(
                                          labelText: 'Quartier',
                                          getValue: _getValue,
                                        ),
                                ),

                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Loyer",
                                        autofocus: false,
                                        hintText: "ex: 30 000 FCFA / mois",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return 'Le loyer ne peux pas être vide';
                                          }
                                        },
                                        onSave: (input) => _loyer = input,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Nombre de mois minimum",
                                        autofocus: false,
                                        hintText: "ex: 10 mois",
                                        validate: (input) {
                                          _min_mois = input;
                                        },
                                        onSave: (input) => _min_mois = input,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Type",
                                        autofocus: false,
                                        hintText:
                                            "ex: Chambre, Appartement, Studio, Maison",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return 'Le type ne peux pas être vide';
                                          }
                                        },
                                        onSave: (input) => _type = input,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Statut",
                                        autofocus: false,
                                        hintText: "ex: A louer ou A vendre",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return 'Le statut ne peux pas être vide';
                                          }
                                        },
                                        onSave: (input) => _statut = input,
                                        obscureText: _obscureText),
                                  ],
                                ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 10.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                //salon
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Description Salon",
                                        autofocus: false,
                                        hintText: "",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return "la description ne peux pas être vide";
                                          }
                                        },
                                        onSave: (input) => input != null
                                            ? _salonDescription = input
                                            : null,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Text(
                                            'Image Salon',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: 47,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            color: darkGrey,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 12),
                                            child: _imageSalon != null
                                                ? Text(_imageSalon.path,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff)))
                                                : Text('',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: 55,
                                          child: FloatingActionButton(
                                            heroTag: 'addImageSalon',
                                            onPressed: chooseFileSalon,
                                            tooltip: 'Pick Image',
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 17,
                                              color: white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 10.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: _salonProgress != 0
                                            ? LinearProgressIndicator(
                                                minHeight: 8,
                                                value: _salonProgress,
                                                backgroundColor: primaryColor,
                                              )
                                            : null),
                                  ],
                                ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 10.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                //cuisine
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Description Cuisine",
                                        autofocus: false,
                                        hintText: "",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return "la description ne peux pas être vide";
                                          }
                                        },
                                        onSave: (input) => input != null
                                            ? _cuisineDescription = input
                                            : null,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Text(
                                            'Image Cuisine',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: 47,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            color: darkGrey,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 12),
                                            child: _imageCuisine != null
                                                ? Text(_imageCuisine.path,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff)))
                                                : Text('',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: 55,
                                          child: FloatingActionButton(
                                            heroTag: 'addImageCuisine',
                                            onPressed: chooseFileCuisine,
                                            tooltip: 'Pick Image',
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 17,
                                              color: white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 10.0),
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.85,
                                        child: _cuisineProgress != 0
                                            ? LinearProgressIndicator(
                                          minHeight: 8,
                                          value: _cuisineProgress,
                                          backgroundColor: primaryColor,
                                        )
                                            : null),
                                  ],
                                ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 10.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                //chambre
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Description Chambre",
                                        autofocus: false,
                                        hintText: "",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return "la description ne peux pas être vide";
                                          }
                                        },
                                        onSave: (input) => input != null
                                            ? _chambreDescription = input
                                            : null,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Text(
                                            'Image Chambre',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: 47,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            color: darkGrey,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 12),
                                            child: _imageChambre != null
                                                ? Text(_imageChambre.path,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff)))
                                                : Text('',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: 55,
                                          child: FloatingActionButton(
                                            heroTag: 'addImageChambre',
                                            onPressed: chooseFileChambre,
                                            tooltip: 'Pick Image',
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 17,
                                              color: white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 10.0),
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.85,
                                        child: _chambreProgress != 0
                                            ? LinearProgressIndicator(
                                          minHeight: 8,
                                          value: _chambreProgress,
                                          backgroundColor: primaryColor,
                                        )
                                            : null),
                                  ],
                                ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 10.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                //douche
                                Row(
                                  children: <Widget>[
                                    InputTextField(
                                        labelText: "Description Douche",
                                        autofocus: false,
                                        hintText: "",
                                        validate: (input) {
                                          if (input.isEmpty) {
                                            return "la description ne peux pas être vide";
                                          }
                                        },
                                        onSave: (input) => input != null
                                            ? _doucheDescription = input
                                            : null,
                                        obscureText: _obscureText),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, bottom: 5),
                                          child: Text(
                                            'Image Douche',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: 47,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            color: darkGrey,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 12),
                                            child: _imageDouche != null
                                                ? Text(_imageDouche.path,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff)))
                                                : Text('',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(0xffffffff))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          height: 55,
                                          child: FloatingActionButton(
                                            heroTag: 'addImageDouche',
                                            onPressed: chooseFileDouche,
                                            tooltip: 'Pick Image',
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 17,
                                              color: white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 10.0),
                                        width:
                                        MediaQuery.of(context).size.width *
                                            0.85,
                                        child: _doucheProgress != 0
                                            ? LinearProgressIndicator(
                                          minHeight: 8,
                                          value: _doucheProgress,
                                          backgroundColor: primaryColor,
                                        )
                                            : null),
                                  ],
                                ),

                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0,
                                        left: 20.0,
                                        right: 20.0,
                                        bottom: 10.0),
                                    child: Divider(
                                      thickness: 1,
                                      height: 2,
                                    ),
                                  ),
                                ),

                                //autresImages


                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20.0, bottom: 30.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 45,
                                      child: RaisedButton(
                                        // padding: EdgeInsets.only(bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    35.0)),
                                        onPressed: () {
                                          _scaffoldKey.currentState
                                              .setState(() {
                                            setDataFields();
                                          });
                                        },
                                        color: primaryColor,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: "Valider",
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
                                ),
                              ],
                            ),
                          )),
                    ]));
          }),
        ));
  }

  Future chooseFileSalon() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageSalon = image;
        uploadFileSalon(_imageSalon);
      });
    });
  }

  Future chooseFileChambre() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageChambre = image;
        uploadFileChambre(_imageChambre);
      });
    });
  }

  Future chooseFileCuisine() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageCuisine = image;
        uploadFileCuisine(_imageCuisine);
      });
    });
  }

  Future chooseFileDouche() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageDouche = image;
        uploadFileDouche(_imageDouche);
      });
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image1 = image;
      });
    });
  }

  Future setDataFields() async {
    final FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      List _salon = [_salonDescription, _salonURL];
      List _douche = [_doucheDescription, _doucheURL];
      List _cuisine = [_cuisineDescription, _cuisineURL];
      List _chambre = [_chambreDescription, _chambreURL];
      List _autresPhotos;

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
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,
                      ),
                    ),
                  )
              );
            });

        _user_id = widget.currentUser.uid;
        _date_ajout = Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch);

        DocumentReference docRef =
            await FirebaseFirestore.instance.collection('entries').add({});

        FirebaseFirestore.instance.collection('entries').doc(docRef.id).set({
          'description': _description,
          'user_id': _user_id,
          'statut': _statut,
          'type': _type,
          'quartier': _selectedValue,
          'loyer': _loyer,
          'entry_id': docRef.id,
          'min_mois': _min_mois,
          'titre': _titre,
          'date_ajout': _date_ajout,
          'salon': _salon,
          'douche': _douche,
          'cuisine': _cuisine,
          'chambre': _chambre
        });
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DisplayMyEntries()
            )
        );
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DisplayMyEntries()
            )
        );
      } catch (e) {
        print(e.code);

        switch (e.code) {
          case "network-request-failed":
            {
              _scaffoldKey.currentState.setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(
                              "Erreur de connexion. Veuillez Vérifier votre connexion Internet"),
                        ),
                      );
                    });
              });
            }
            break;
          default:
            _scaffoldKey.currentState.setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text("Erreur inconnue. Veuillez réesayer"),
                      ),
                    );
                  });
            });
            break;
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future uploadFileSalon(File image) async {
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('entriesImages/${Path.basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      uploadTask.events.listen((event) {
        setState(() {
          print(_salonProgress);
          _salonProgress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
        });
      }).onError((error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  child: Text("Erreur inconnue. Veuillez réesayer"),
                ),
              );
            });
      });
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _salonURL = fileURL;
          isLoading = false;
          print(_salonURL);
        });
      });
    }
  }

  Future uploadFileCuisine(File image) async {
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('entriesImages/${Path.basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      uploadTask.events.listen((event) {
        setState(() {
          print(_cuisineProgress);
          _cuisineProgress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
        });
      }).onError((error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  child: Text("Erreur inconnue. Veuillez réesayer"),
                ),
              );
            });
      });
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _cuisineURL = fileURL;
          isLoading = false;
        });
      });
    }
  }

  Future uploadFileChambre(File image) async {
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('entriesImages/${Path.basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      uploadTask.events.listen((event) {
        setState(() {
          print(_chambreProgress);
          _chambreProgress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
        });
      }).onError((error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  child: Text("Erreur inconnue. Veuillez réesayer"),
                ),
              );
            });
      });
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _chambreURL = fileURL;
          isLoading = false;
          print(_salonURL);
        });
      });
    }
  }

  Future uploadFileDouche(File image) async {
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('entriesImages/${Path.basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      uploadTask.events.listen((event) {
        setState(() {
          print(_doucheProgress);
          _doucheProgress = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
        });
      }).onError((error) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  child: Text("Erreur inconnue. Veuillez réesayer"),
                ),
              );
            });
      });
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _doucheURL = fileURL;
          isLoading = false;
          print(_salonURL);
        });
      });
    }
  }

  Future uploadFile1(File image) async {
    if (image != null) {
      setState(() {
        isLoading = true;
      });
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('entriesImages/${Path.basename(image.path)}}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _image1URL = fileURL;
          isLoading = false;
        });
      });
    }
  }
}
