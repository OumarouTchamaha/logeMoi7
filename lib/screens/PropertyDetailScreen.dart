import 'package:LogeMoi/library/Card.dart';
import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/models/Property.dart';
import 'package:LogeMoi/screens/DisplayMyEntries.dart';
import 'package:LogeMoi/screens/LoginScreen.dart';
import 'package:LogeMoi/screens/RegisterScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';

class PropertyDetailScreen extends StatefulWidget {

  final User loggedUser;
  final String entry_id;

  //List<PropertyDetail> propertyDetails = [];

  PropertyDetailScreen({this.loggedUser, this.entry_id});
  @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {

  String _pseudo, _mobile, _email;

  DocumentSnapshot entryInfo;
  DocumentSnapshot userInfo;

  CollectionReference databaseReference = FirebaseFirestore.instance.collection('entries');
  CollectionReference databaseReference2 = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    //print(widget.propertyDetails.length);
    return Scaffold(
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 180,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: white,
                        ),
                      ),
                    ),
                    title: Text(
                      "Details     ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          color: white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                    ),
                  contentPadding: EdgeInsets.only(right: 80.0),
                    ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('entries')
                    .doc(widget.entry_id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new Text("Loading");
                  }
                  entryInfo = snapshot.data;

                  List<String> salon = List.castFrom(entryInfo.data()['salon']);
                  List<String> cuisine = List.castFrom(entryInfo.data()['cuisine']);
                  List<String> douche = List.castFrom(entryInfo.data()['douche']);
                  List<String> chambre = List.castFrom(entryInfo.data()['chambre']);

                  List<PropertyDetail> propertyDetails = [
                    PropertyDetail(description: salon.elementAt(0), image: salon.elementAt(1), title: 'Salon'),
                    PropertyDetail(description: cuisine.elementAt(0), image: cuisine.elementAt(1), title: 'Cuisine'),
                    PropertyDetail(description: chambre.elementAt(0), image: chambre.elementAt(1), title: 'Chambre'),
                    PropertyDetail(description: douche.elementAt(0), image: douche.elementAt(1), title: 'Douche'),
                  ];
                  print(propertyDetails[0].description);
                  return new Container(
                    child:
                    Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              height: 260,
                              color: Colors.transparent,
                              margin: EdgeInsets.only(top: 90),
                              child: Swiper(
                                loop: false,
                                itemWidth: 340,
                                itemHeight: 400,
                                index: 0,
                                itemCount: propertyDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PropertyDetailCard(
                                      image: propertyDetails[index].image,
                                      title: propertyDetails[index].title,
                                      description: propertyDetails[index].description);
                                },
                                viewportFraction: 0.75,
                                pagination: new SwiperPagination(
                                    alignment: Alignment(0, 1.4),
                                    builder: DotSwiperPaginationBuilder(color: grey)),
                                scale: 0.8,
                                layout: SwiperLayout.DEFAULT,
                              ),

                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Divider(
                                  thickness: 1,
                                  height: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // color: primaryColor,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Text(entryInfo.data()['titre'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Divider(
                                      thickness: 1,
                                      height: 8,
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            StreamBuilder(
                                                stream: FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(entryInfo.data()['user_id'])
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return new Text("Loading");
                                                  }
                                                  userInfo = snapshot.data;
                                                  _pseudo = userInfo.data()['pseudo'];
                                                  _mobile = userInfo.data()['mobile'].toString();
                                                  _email = userInfo.data()['email'];
                                                  return new Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Icon(
                                                        SimpleLineIcons.user,
                                                        size: 17,
                                                        color: primaryColor,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        "Publicateur : ",
                                                        style: TextStyle(fontSize: 15, color: grey),
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        _pseudo,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w800),
                                                      )
                                                    ],
                                                  );
                                                }),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  SimpleLineIcons.clock,
                                                  size: 17,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Durée Minimum : ",
                                                  style: TextStyle(fontSize: 15, color: grey),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  entryInfo.data()['min_mois'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Icon(
                                                  SimpleLineIcons.user,
                                                  size: 17,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Type : ",
                                                  style: TextStyle(fontSize: 15, color: grey),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  entryInfo.data()['type'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Icon(
                                                  SimpleLineIcons.user,
                                                  size: 17,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Statut : ",
                                                  style: TextStyle(fontSize: 15, color: grey),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  entryInfo.data()['statut'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  AntDesign.creditcard,
                                                  size: 17,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Loyer : ",
                                                  style: TextStyle(fontSize: 15, color: grey),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  entryInfo.data()['loyer'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Icon(
                                                  AntDesign.profile,
                                                  size: 17,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Date Ajout : ",
                                                  style: TextStyle(fontSize: 15, color: grey),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  entryInfo.data()['date_ajout'].toDate().toString().substring(0, 19),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          maxRadius: 45,
                                          minRadius: 45,
                                          backgroundColor: grey,
                                          child: Icon(
                                            Icons.account_circle,
                                            size: 70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                                child: Divider(
                                  thickness: 1,
                                  height: 2,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.0, bottom: 10.0),
                                      child:
                                      Icon(AntDesign.infocirlceo, color: primaryColor, size: 17,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.0, bottom: 10.0, left: 5.0),
                                      child:
                                      Text('Description : ',
                                        style:
                                        TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: grey
                                        ),),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 50),
                                      child:
                                      Text(entryInfo.data()['description'],
                                        style:
                                        TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                                child: Divider(
                                  thickness: 1,
                                  height: 2,
                                ),
                              ),
                            ),
//                            Column(
//                              children: [
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: [
//                                    Padding(
//                                      padding: EdgeInsets.only(left: 30.0, bottom: 10.0),
//                                      child:
//                                      Icon(AntDesign.picture, color: primaryColor, size: 17,),
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(top: 1.0, bottom: 10.0, left: 5.0),
//                                      child:
//                                      Text('Gallerie d\'images : ',
//                                        style:
//                                        TextStyle(
//                                            fontSize: 15,
//                                            fontWeight: FontWeight.normal,
//                                            color: grey
//                                        ),),
//                                    ),
//                                  ],
//                                ),
//                                Wrap(
//                                  direction: Axis.horizontal,
//                                  children: [
//                                    Padding(
//                                      padding: EdgeInsets.symmetric(horizontal: 50),
//                                      child:
//                                      Text('Très bell appartement modèrne situé en bordure de route. '
//                                          'Situé dans le quartier résidentiel de bonapriso, il dispose d\'un parking privé,'
//                                          'D\'un gardien disponoble 24h/24',
//                                        style:
//                                        TextStyle(
//                                            fontSize: 15,
//                                            fontWeight: FontWeight.bold
//                                        ),),
//                                    )
//                                  ],
//                                ),
//                              ],
//                            ),
                            Container(
                              height: 20,
                            ),
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 45,
                                child: RaisedButton(
                                  // padding: EdgeInsets.only(bottom: 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(35.0)),
                                  onPressed: () {
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 280,
                                                width: 400,
                                                child: !widget.loggedUser.isAnonymous ?
                                                Container(
                                                    alignment: Alignment.center,
                                                    width: 300,
                                                    height: 150,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(_pseudo, style:
                                                        TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                                                            child: Divider(
                                                              thickness: 1,
                                                              height: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Mobile : ', style:
                                                                TextStyle(
                                                                    color: darkGrey,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.normal
                                                                ),),
                                                                Text(_mobile, style:
                                                                TextStyle(
                                                                    color: primaryColor,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Mail : ', style:
                                                                TextStyle(
                                                                    color: darkGrey,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.normal
                                                                ),),
                                                                Text(_email, style:
                                                                TextStyle(
                                                                    color: primaryColor,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold
                                                                ),),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                  top: 10.0, bottom: 0.0,),
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
                                                                          child: PropertyDetailScreen(),
                                                                        )
                                                                    );
                                                                  },
                                                                  color: darkGrey,
                                                                  child: RichText(
                                                                    text: TextSpan(children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "Fermer",
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
                                                ) :
                                                Container(
                                                    alignment: Alignment.center,
                                                    width: 400,
                                                    height: 280,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text('Invité', style:
                                                        TextStyle(
                                                            color: primaryColor,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        Container(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                                                            child: Divider(
                                                              thickness: 1,
                                                              height: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Pour acceder à ces informations', style:
                                                                TextStyle(
                                                                    color: darkGrey,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.normal
                                                                ),),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('veuillez:', style:
                                                                TextStyle(
                                                                    color: darkGrey,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.normal
                                                                ),),
                                                              ],
                                                            ),

                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Center(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                      top: 10.0, bottom: 0.0,),
                                                                    child: RaisedButton(
                                                                      // padding: EdgeInsets.only(bottom: 10),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          new BorderRadius.circular(
                                                                              35.0)),
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            PageTransition(
                                                                              type: PageTransitionType.rightToLeft,
                                                                              child: LoginScreen(),
                                                                            )
                                                                        );
                                                                      },
                                                                      color: primaryColor,
                                                                      child: RichText(
                                                                        text: TextSpan(children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: "Vous Connecter",
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
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Center(
                                                                  child: Padding(
                                                                    padding: EdgeInsets.only(
                                                                      top: 10.0, bottom: 0.0,),
                                                                    child: RaisedButton(
                                                                      // padding: EdgeInsets.only(bottom: 10),
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                          new BorderRadius.circular(
                                                                              35.0)),
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            PageTransition(
                                                                              type: PageTransitionType.rightToLeft,
                                                                              child: RegisterScreen(),
                                                                            )
                                                                        );
                                                                      },
                                                                      color: white,
                                                                      child: RichText(
                                                                        text: TextSpan(children: <TextSpan>[
                                                                          TextSpan(
                                                                              text: "Vous Enregistrer",
                                                                              style: TextStyle(
                                                                                  color: primaryColor,
                                                                                  fontSize: 16,
                                                                                  fontWeight:
                                                                                  FontWeight.bold)),
                                                                        ]),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Center(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                  top: 10.0, bottom: 0.0,),
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
                                                                          child: PropertyDetailScreen(),
                                                                        )
                                                                    );
                                                                  },
                                                                  color: darkGrey,
                                                                  child: RichText(
                                                                    text: TextSpan(children: <TextSpan>[
                                                                      TextSpan(
                                                                          text: "Fermer",
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
                                                )
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  color: primaryColor,
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "Voir le Contact",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 35.0,)
                          ],
                        ),
                      ],
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
