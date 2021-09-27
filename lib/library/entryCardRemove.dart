import 'dart:ui';

import 'package:LogeMoi/models/Property.dart';
import 'package:LogeMoi/screens/DisplayMyEntries.dart';
import 'package:LogeMoi/screens/PropertyDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:page_transition/page_transition.dart';

import './Common.dart';

class PropertyDisplayCardRemove extends StatefulWidget{
  String titre;
  String loyer;
  String min_mois;
  String quartier;
  String entry_id;


  PropertyDisplayCardRemove({this.titre, this.loyer, this.min_mois, this.quartier, this.entry_id});

  @override
  State<StatefulWidget> createState() {
    return new _PropertyDisplayCardRemoveState();
  }

}

class _PropertyDisplayCardRemoveState extends State<PropertyDisplayCardRemove> {
  Widget leftPartEntry(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        //width: 250,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(2, 6),
                  blurRadius: 10)
            ],
        ),
        // color: Colors.green,
        //height: 110,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.titre,
                    overflow: TextOverflow.ellipsis,
                    style: prefix0.TextStyle(
                        fontSize: 18,
                        color: Color(0xFF465C61),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Quartier : "+ widget.quartier,
                  style: prefix0.TextStyle(
                    fontSize: 14,
                    color: Color(0xFF94979C),
                    height: 1.8,
                  ),
                ),
                Text(
                  "Loyer: "+ widget.loyer,
                  style: prefix0.TextStyle(
                    fontSize: 14,
                    height: 1,
                    color: Color(0xFF94979C),
                  ),
                ),
                Text(
                  "Minimum : "+ widget.min_mois,
                  style: prefix0.TextStyle(
                    fontSize: 14,
                    color: Color(0xFF94979C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rightPartEntry(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        //width: 80,
        // padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(2, 6),
                  blurRadius: 10)
            ],
        ),
        //height: 110,
        child: InkWell(
        onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: PropertyDetailScreen(entry_id: widget.entry_id,),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Voir",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: white),
              ),
              Text(
                "Plus",
                style: TextStyle(
                    color: white,
                    height: 1.2,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget  middlePartEntry(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        //width: 80,
        // padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: const Offset(2, 6),
                blurRadius: 10)
          ],
        ),
        //height: 110,
        child: InkWell(
          onTap: (){
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: SizedBox(
                          height: 150,
                          width: 200,
                          child: Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Confirmez vous la supression de cette annonce ?', style:
                                  TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 20.0, bottom: 0.0),
                                      child: RaisedButton(
                                        // padding: EdgeInsets.only(bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(
                                                35.0)),
                                        onPressed: () {
                                          deleteEntry();
                                        },
                                        color: Colors.redAccent,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: "Supprimer",
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
                                          Navigator.pop(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child: DisplayMyEntries(),
                                              )
                                          );
                                        },
                                        color: darkGrey,
                                        child: RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: "Annuler",
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
                                ],)
                              ],
                            )
                            ),
                          ),
                        );
                  });
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Supprimer",
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.red[50],
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      child: Row(
        children: <Widget>[leftPartEntry(context), rightPartEntry(context), middlePartEntry(context)],
      ),
    );
  }

  Future deleteEntry() async {
    try{
       CollectionReference databaseReference = await FirebaseFirestore.instance.collection('entries');

       databaseReference.doc(widget.entry_id).delete();
       Navigator.pop(
           context,
           PageTransition(
             type: PageTransitionType.rightToLeft,
             child: DisplayMyEntries(),
           )
       );

    }catch(e){
      switch (e.code) {
        case "network-request-failed":
          {
            setState(() {
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
          setState(() {
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


  }
}



