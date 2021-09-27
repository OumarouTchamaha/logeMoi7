import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/library/entryCard.dart';
import 'package:LogeMoi/screens/AddEntry.dart';
import 'package:LogeMoi/screens/RemoveEntry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DisplayMyEntries extends StatefulWidget {
  User loggedUser;


  DisplayMyEntries({this.loggedUser});

  @override
  _DisplayMyEntriesState createState() => _DisplayMyEntriesState();
}

class _DisplayMyEntriesState extends State<DisplayMyEntries> {
  CollectionReference databaseReference =
  FirebaseFirestore.instance.collection('entries');
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double abovePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom - 15;
    print(abovePadding);
    double leftHeight = screenHeight - abovePadding;

    String _radioItem = 'Client';

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text('Mes Anonnces'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AddEntry(currentUser: widget.loggedUser,),
                ),
              );
            },
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: RemoveEntry(loggedUser: widget.loggedUser,),
                ),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Container(
                height: leftHeight,
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 10),
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.only(top: 0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: leftHeight-80,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: databaseReference.limit(20).where('user_id', isEqualTo: widget.loggedUser.uid).snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return new Text('${snapshot.error}');
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: Text('No data'),
                                        );
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Center(
                                              child: new CircularProgressIndicator());
                                        default:
                                          return ListView(
                                              children: snapshot.data.docs
                                                  .map<Widget>((QueryDocumentSnapshot doc) {
                                                return PropertyDisplayCard(
                                                  entry_id: doc.data()['entry_id'],
                                                  min_mois: doc.data()['min_mois'],
                                                  loyer: doc.data()['loyer'],
                                                  quartier: doc.data()['quartier'],
                                                  titre: doc.data()['titre'],
                                                );
                                              }).toList());
                                      }
                                    },
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ));
  }
}
