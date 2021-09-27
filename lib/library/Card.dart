import 'dart:ui';

import 'package:LogeMoi/library/entryCard.dart';
import 'package:LogeMoi/models/Property.dart';
import 'package:LogeMoi/screens/PropertyDetailScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';

import './Common.dart';

class PropertyIntroCard extends StatelessWidget {
  Widget leftPart(BuildContext context) {
    return Container(
      width: 190,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      // color: Colors.green,
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Villa à louer",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "Ndongbong",
            style: TextStyle(color: grey, height: 1.5, fontSize: 13),
          ),
          Text(
            "10 Chambres",
            style: TextStyle(color: grey, height: 0.9, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget rightPart(BuildContext context) {
    return Container(
      width: 60,
      // padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      height: 70,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: <Widget>[leftPart(context), rightPart(context)],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {

  String titre;
  String quartier;
  String loyer;
  String statut, type;
  String dateAjout;
  String entry_id;
  User loggedUser;
  String min_mois;
  String imageURL;


  PropertyCard({this.titre, this.quartier, this.loyer, this.statut, this.type,
    this.dateAjout, this.entry_id, this.min_mois, this.loggedUser, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
//        Navigator.push(
//            context,
//            PageTransition(
//                type: PageTransitionType.rightToLeft,
//                child: PropertyDetailScreen(propertyDetails: propertyDetails)));
      },
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imageURL,
            fit: BoxFit.fill,
            imageBuilder: (context, imageProvider) =>
                Container(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(2, 6),
                            blurRadius: 10)
                      ]),
                ),
            placeholder:(context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,),),
            errorWidget:(context, url, error) => Center(child: Icon(FontAwesome.exclamation_triangle),),

          ),
          Container(
            height: 260,
            // width: double.infinity,
            decoration: BoxDecoration(color: Color.fromRGBO(33, 33, 33, 0.1)),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff00D171)),
                    height: 30,
                    width: 90,
                    child: Center(
                      child: Text(
                        type,
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.9,
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: new BoxDecoration(
                        border: Border.all(color: white, width: 0.5),
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      height: 30,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: white,
                          ),
                          Text(
                            dateAjout.substring(0, 19),
                            style: TextStyle(fontSize: 13, color: white),
                          )
                        ],
                      )),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: PropertyDisplayCard(
                    entry_id: entry_id,
                    loyer: loyer,
                    min_mois: min_mois,
                    quartier: quartier,
                    titre: titre,
                    loggedUser: loggedUser,
                  ),
                ),
                Positioned(
                  bottom: 130,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    decoration: new BoxDecoration(
                      border: Border.all(color: primaryColor, width: 0),
                      borderRadius: new BorderRadius.circular(10.0),
                      color: primaryColor,
                    ),
                    height: 30,
                    width: 75,
                    child: Center(
                      child: Text(
                        statut,
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyCard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      height: 110,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Chambre à Louer",
                style: prefix0.TextStyle(
                    fontSize: 22,
                    color: Color(0xFF465C61),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Quartier : Bonapriso",
                style: prefix0.TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94979C),
                  height: 1.8,
                ),
              ),
              Text(
                "Bail: 50 000 CFA/mois",
                style: prefix0.TextStyle(
                  fontSize: 14,
                  height: 1,
                  color: Color(0xFF94979C),
                ),
              ),
              Text(
                "Minimum : 12 mois",
                style: prefix0.TextStyle(
                  fontSize: 14,
                  color: Color(0xFF94979C),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PropertyDetailCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const PropertyDetailCard({Key key, this.image, this.title, this.description})
      : super(key: key);
  Widget PropertyDetailIntroCard() {
    return Container(
      height: 80,
      width: 200,
      padding: EdgeInsets.only(top: 5, left: 5, right: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: const Offset(2, 6),
                blurRadius: 10)
          ]),
      child: Column(
        children: <Widget>[
          Text(title != null ? title : '',
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          Padding(
              padding: EdgeInsets.only(left: 5, top: 5),
              child: Text(description != null ? description : '',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w900)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) =>
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(2, 6),
                      blurRadius: 10)
                ]),
          ),
      placeholder:(context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(primaryColor), strokeWidth: 5,),),
      errorWidget:(context, url, error) => Center(child: Icon(FontAwesome.exclamation_triangle),),

    ),
        Container(
          height: 260,
          // width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color.fromRGBO(33, 33, 33, 0.1)
          ),
          child: Stack(

            children: <Widget>[
              Positioned(
                bottom: 30,
                right: 0,
                child: PropertyDetailIntroCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
