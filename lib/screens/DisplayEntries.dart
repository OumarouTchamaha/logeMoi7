import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/library/entryCard.dart';
import 'package:LogeMoi/widgets/quartierButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayEntries extends StatefulWidget {
  @override
  _DisplayEntriesState createState() => _DisplayEntriesState();
}

Widget input({String labelText, String hintText}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15, bottom: 5),
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 15),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(80),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.0),
              ),
              // disabledBorder: new InputBorder(borderSide: BorderSide.none),
              hintStyle: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Color(0xffffffff)),
              filled: true,
              fillColor: darkGrey,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 17, vertical: 12),

              hintText: hintText,
            ),
          ),
        ),
      ],
    ),
  );
}

class _DisplayEntriesState extends State<DisplayEntries> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double abovePadding = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom -
        15;
    print(abovePadding);
    double leftHeight = screenHeight - abovePadding;

    var _quartiers;
    List<String> _quartiersList;

    String _radioItem = 'Client';

    CollectionReference databaseReference =
        FirebaseFirestore.instance.collection('entries');

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text('Anonnces'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 0),
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
              margin: EdgeInsets.only(top: 3),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(top: 0, bottom: 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                      height: 40,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Quartiers : ",
                                            style: TextStyle(
                                                height: 2,
                                                fontSize: 17,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10.0),
                                          ),
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('quartiers')
                                                  .doc('Douala')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return new Text('Chargement');
                                                }
                                                int index = 0;
                                                _quartiers = snapshot.data;
                                                _quartiersList = List.castFrom(
                                                    _quartiers
                                                        .data()['quartiers']);
                                                return Expanded(
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            _quartiersList
                                                                .length,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (BuildContext ctxt,
                                                                int index) {
                                                          return new Container(
                                                              child: _quartiersList
                                                                  .map((String
                                                                      value) {
                                                            return QuartierButton(
                                                              nomQuartier:
                                                                  value,
                                                            );
                                                          }).elementAt(index));
                                                        }),
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                                      //Text('$"Bonjour"', style: TextStyle(fontSize: 23, color: darkGrey),),
                                      ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                height: 8,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              height: leftHeight - 132,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: databaseReference
                                    .limit(20)
                                    .orderBy('date_ajout', descending: true)
                                    .snapshots(),
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
                                          child:
                                              new CircularProgressIndicator());
                                    default:
                                      return ListView(
                                          children: snapshot.data.docs
                                              .map<Widget>(
                                                  (QueryDocumentSnapshot doc) {
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
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
