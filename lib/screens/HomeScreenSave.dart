import 'package:LogeMoi/library/Card.dart';
import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/library/MyAppBar.dart';
import 'package:LogeMoi/library/entryCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';

import 'DisplayEntries.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;

  HomeScreen({this.currentUser});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                    leading: Container(
                      width: 20,
                    ),
                    title: Text(
                      "Locations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          color: white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.add_circle,
                        size: 38,
                        color: white,
                      ),
                    )),
              ),
            ),
            MyAppBar(
              title: "Acceuil",
            ),
            Container(
              height: 260,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 90),
              child: Swiper(
                itemWidth: 340,
                itemHeight: 400,
                itemBuilder: (BuildContext context, int index) {
                  return PropertyCard();
                },
                itemCount: 10,
                viewportFraction: 0.75,
                pagination: new SwiperPagination(
                    alignment: Alignment(0, 1.4),
                    builder: DotSwiperPaginationBuilder(color: grey)),
                scale: 0.8,
                layout: SwiperLayout.DEFAULT,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 400),
              height: 410,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 8,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Annonces",
                        style: TextStyle(
                            height: 2,
                            fontSize: 17,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.downToUp,
                                  child: DisplayEntries(),
                                ),
                              );
                            },
                            child: Text("Voir plus",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 2,
                                    fontSize: 15,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 350,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return PropertyDisplayCard(
                            titre: 'Chambre à vendre',
                            quartier: 'Bonanjo',
                            loyer: '20 000 FCFA/mois',
                            min_mois: '10 mois',);
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
